require 'rails_helper'

describe "Admin Item Actions", type: :feature do
  let(:admin_user1) { create(:admin_user) }
  let(:admin_user2) { create(:admin_user, establishment: 'Mount Everest') }

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
  end

  scenario "admin can not sell wrong quantity of item" do
    admin_item_create
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 4
    click_on 'Sold'
    expect(page).to have_content("Quantity sold should be less than the available stock")
  end

  scenario "admin can not sell without new sale value" do
    admin_item_create
    click_on 'Sell'
    click_on 'Sold'
    expect(page).to have_content('No sale')
  end

  scenario "admin can update item" do
    admin_item_create
    click_on 'Edit'
    select 'Fashion', from: 'Category'
    click_on 'Save'
    expect(page).not_to have_content("Music")
    expect(page).to have_content("Fashion")
    expect(page).to have_content("'Mortal Kombat X' has been successfully updated")
  end

  scenario "admin can delete item" do
    admin_item_create
    click_on 'Delete'
    expect(page).not_to have_content("Music")
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
end
