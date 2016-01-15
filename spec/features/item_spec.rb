require 'rails_helper'

describe 'employee Item Actions', type: :feature do
  let(:admin_user) { create(:admin_user) }
  let(:admin_user2) { create(:admin_user, establishment: 'Mount Everest') }
  let(:user) { create(:user, admin_user: admin_user) }
  let(:user2) { create(:user, admin_user: admin_user) }
  let(:user3) { create(:user, admin_user: admin_user2) }

  before do
    # only admins can create items
    visit admin_root_path
    admin_login admin_user
    admin_creates_item
    click_on 'Log Out'

    visit root_path
    login user
  end

  scenario "employee can see all items" do
    expect(page).to have_content("Toys for Kids")
  end

  scenario "employee can sell item" do
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 2
    click_on 'Sold'
    expect(page).to have_content("You just sold 2 piece(s) of Barbie Doll")
  end

  scenario "employee can not sell wrong quantity of item" do
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 4
    click_on 'Sold'
    expect(page).to have_content("Quantity sold should be less than the available stock")
  end

  scenario "employee does not input new sale value" do
    click_on 'Sell'
    click_on 'Sold'
    expect(page).to have_content('No sale')
  end

  scenario "employee with the same admin will see items" do
    click_on 'Log Out'
    login user2
    expect(page).to have_content("Toys for Kids")
  end

  scenario "employee with different admin will not see items" do
    click_on 'Log Out'
    login user3
    expect(page).not_to have_css("table.table", text: "Toys for Kids")
  end

  scenario "employee can sell all items" do
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 3
    click_on 'Sold'
    expect(page).to have_content("You just sold 3 piece(s) of Barbie Doll")
  end

  scenario "employee can not sell in negative" do
    click_on 'Sell'
    fill_in 'Quantity Sold', with: -3
    click_on 'Sold'
    expect(page).to have_content("Invalid Quantity")
  end

  scenario "employee can search for item" do
    click_on 'Log Out'
    given_admin_creates_another_item
    and_logs_out
    when_i_log_in
    and_search_for_an_item
    then_i_should_see_the_result
  end

  scenario "employee can filter by category" do
    click_on 'Log Out'
    given_admin_creates_another_item
    and_logs_out
    when_i_log_in
    and_filter_by_category
    then_i_should_see_only_that_category
  end

  scenario "no items if category is not available" do
    click_on 'Log Out'
    given_admin_creates_another_item
    and_logs_out
    when_i_log_in
    and_filter_by_an_unavailable_category

  end

  def admin_creates_item
    click_on 'Create a new Item'
    select 'Toys for Kids', from: 'Category'
    fill_in 'Name', with: 'Barbie Doll'
    fill_in 'Quantity', with: '3'
    fill_in 'Minimum Quantity', with: '1'
    click_on 'Save'
  end

  def given_admin_creates_another_item
    visit admin_root_path
    admin_login admin_user
    click_on 'Create a new Item'
    select 'Games', from: 'Category'
    fill_in 'Name', with: 'Xbox'
    fill_in 'Quantity', with: '5'
    fill_in 'Minimum Quantity', with: '2'
    click_on 'Save'
  end

  def and_logs_out
    click_on 'Log Out'
  end

  def when_i_log_in
    visit root_path
    login user
  end

  def and_search_for_an_item
    visit items_path(q: 'game')
  end

  def then_i_should_see_the_result
    expect(page).to have_content('Xbox')
    expect(page).not_to have_content('Doll')
  end

  def and_filter_by_category
    visit items_path(filter_by: 'Toys for Kids')
  end

  def then_i_should_see_only_that_category
    expect(page).not_to have_content("Xbox")
    expect(page).not_to have_css("table.table", text: "Games")
    expect(page).to have_content("Barbie Doll")
  end

  def and_filter_by_an_unavailable_category
    visit items_path(filter_by: 'Toys for Kids')
  end

  def then_i_should_get_a_message
    expect(page).to have_content("No item matches your search")
    expect(page).not_to have_css("table.table", text: "Games")
    expect(page).not_to have_css("table.table", text: "Toys for Kids")
  end
end
