require 'rails_helper'

describe "Admin Item Actions", type: :feature do
  let(:admin_user1) { create(:admin_user) }
  let(:admin_user2) { create(:admin_user, establishment: 'Mount Everest') }
  let(:email) { ActionMailer::Base.deliveries.last }

  before do
    given_i_visit_the_app
  end

  def given_i_visit_the_app
    visit admin_root_path
  end

  scenario "admin can create item" do
    admin_item_create
  end

  scenario "admin can sell valid item" do
    admin_item_create
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 2
    click_on 'Sold'
    expect(page).to have_content("You just sold 2 piece(s) of Mortal Kombat X")
    expect(email.to).to eq([admin_user1.email]) # minimum quantity was hit
  end

  scenario "admin can not sell wrong quantity of item" do
    admin_item_create
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 4
    click_on 'Sold'
    expect(page).to have_content("Quantity sold should be less than the available stock")
  end

  scenario "admin can not sell without sale value" do
    admin_item_create
    click_on 'Sell'
    click_on 'Sold'
    expect(page).to have_content('No sales made')
  end

  scenario "admin can update item" do
    admin_item_create
    click_on 'Edit'
    select 'Fashion', from: 'Category'
    click_on 'Save'
    expect(page).not_to have_css("table.table", text: "Music")
    expect(page).to have_content("Fashion")
    expect(page).to have_content("'Mortal Kombat X' has been successfully updated")
  end

  scenario "admin can delete item" do
    admin_item_create
    click_on 'Delete'
    expect(page).not_to have_css("table.table", text: "Music")
    expect(page).to have_content("This item has been successfully deleted")
  end

  scenario "admin can not set minimum quantity to 0" do
    admin_item_create
    click_on 'Edit'
    fill_in 'Minimum Quantity', with: 0
    click_on 'Save'
    expect(page).to have_content('should not be 0')
  end

  scenario "second admin cannot see first admin item" do
    admin_login admin_user2
    expect(page).not_to have_content('Mortal Kombat X')
    expect(page).not_to have_content('sell')
  end

  scenario "admin can add stock" do
    admin_item_create
    click_on 'Edit'
    click_on 'Add New Stock'
    fill_in 'Add New Stock', with: 10
    click_on 'Add Stock'
    expect(page).to have_field('Quantity', with: '13')
    expect(page).to have_content("You added 10 piece(s) of Mortal Kombat X")
  end

  scenario "different admins can have the same item" do
    admin_item_create
    click_on 'Log Out'
    admin_login admin_user2
    click_on 'Create a new Item'
    when_i_fill_in_item_details
    expect(page).to have_content('Item successfully created')
  end

  scenario "minimum quantity can not be higher than quantity" do
    admin_login admin_user2
    click_on 'Create a new Item'
    select 'Games', from: 'Category'
    fill_in 'Name', with: 'Mortal Kombat X'
    fill_in 'Quantity', with: '3'
    fill_in 'Minimum Quantity', with: '5'
    click_on 'Save'
    expect(page).to have_content("Minimum Quantity should be less than quantity added")
  end

  scenario "admin can not sell in negative" do
    admin_item_create
    click_on 'Sell'
    fill_in 'Quantity Sold', with: -3
    click_on 'Sold'
    expect(page).to have_content("Invalid Quantity")
  end

  scenario "admin can not add stock in negative" do
    admin_item_create
    click_on 'Edit'
    click_on 'Add New Stock'
    fill_in 'Add New Stock', with: -3
    click_on 'Add Stock'
    expect(page).to have_content("Invalid Quantity")
  end

  scenario "admin can not add stock without stock value" do
    admin_item_create
    click_on 'Edit'
    click_on 'Add New Stock'
    fill_in 'Add New Stock', with: 0
    click_on 'Add Stock'
    expect(page).to have_content('Please add a value for the new stock')
  end

  scenario "admin can search for item" do
    admin_item_create
    click_on 'Create a new Item'
    given_i_create_another_item
    when_i_search_for_an_item
    then_i_should_see_the_result
  end

  scenario "admin can search for item with partial string" do
    admin_item_create
    click_on 'Create a new Item'
    given_i_create_another_item
    when_i_search_for_an_item
    then_i_should_see_the_result
  end

  scenario "admin can filter per category" do
    admin_item_create
    click_on 'Create a new Item'
    given_i_create_another_item
    when_i_filter_by_category
    then_i_should_see_only_that_category
  end

  scenario "admin can sort filtered items" do
    admin_item_create
    click_on 'Create a new Item'
    given_i_create_another_item
    when_i_filter_by_category
    click_on 'Brand'
    then_i_should_see_only_that_category
  end

  scenario "admin cannot sort empty filtered items" do
    admin_item_create
    click_on 'Create a new Item'
    given_i_create_another_item
    when_i_filter_by_nonexistent_category
    click_on 'Brand'
    then_i_should_not_see_an_error
  end

  scenario "no items if category is not available" do
    admin_item_create
    click_on 'Create a new Item'
    given_i_create_another_item
    when_i_filter_by_an_unavailable_category
    then_i_should_get_a_message
  end

  def admin_item_create
    admin_login admin_user1
    click_on 'Create a new Item'
    when_i_fill_in_item_details
    expect(page).to have_content('Item successfully created')
  end

  def when_i_fill_in_item_details
    select 'Games', from: 'Category'
    fill_in 'Name', with: 'Mortal Kombat X'
    fill_in 'Quantity', with: '3'
    fill_in 'Minimum Quantity', with: '1'
    click_on 'Save'
  end

  def given_i_create_another_item
    select 'Music', from: 'Category'
    fill_in 'Name', with: 'Recorder'
    fill_in 'Quantity', with: '3'
    fill_in 'Minimum Quantity', with: '1'
    click_on 'Save'
  end

  def when_i_search_for_an_item
    visit admin_items_path(q: 'game')
  end

  def when_i_search_for_an_item_partially
    visit admin_items_path(q: 'ga')
  end

  def then_i_should_see_the_result
    expect(page).to have_content('Mortal Kombat X')
    expect(page).not_to have_css("table.table", text: "Music")
  end

  def when_i_filter_by_category
    visit admin_items_path(filter_by: 'Games')
  end

  def when_i_filter_by_nonexistent_category
    visit admin_items_path(filter_by: 'Toys for Kids')
  end

  def then_i_should_see_only_that_category
    expect(page).not_to have_content("Recorder")
    expect(page).not_to have_css("table.table", text: "Music")
    expect(page).to have_content("Mortal Kombat X")
    expect(page).to have_select('category', selected: 'Games')
    expect(page).to have_content("View all items")
  end

  def then_i_should_not_see_an_error
    expect(page).to have_content('No item matches your search')
  end

  def when_i_filter_by_an_unavailable_category
    visit admin_items_path(filter_by: 'Electronics')
  end

  def then_i_should_get_a_message
    expect(page).to have_content("No item matches your search")
    expect(page).not_to have_css("table.table", text: "Games")
    expect(page).not_to have_css("table.table", text: "Music")
  end
end
