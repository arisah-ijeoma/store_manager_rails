require 'rails_helper'

describe 'User Item Actions', type: :feature do
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

  scenario "user can see all items" do
    expect(page).to have_content("Toys for Kids")
  end

  scenario "user can sell item" do
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 2
    click_on 'Sold'
    expect(page).to have_content("You just sold 2 piece(s) of Barbie Doll")
  end

  scenario "user can not sell wrong quantity of item" do
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 4
    click_on 'Sold'
    expect(page).to have_content("Quantity sold should be less than the available stock")
  end

  scenario "user does not input new sale value" do
    click_on 'Sell'
    click_on 'Sold'
    expect(page).to have_content('No sale')
  end

  scenario "user with the same admin will see items" do
    click_on 'Log Out'
    login user2
    expect(page).to have_content("Toys for Kids")
  end

  scenario "user with different admin will not see items" do
    click_on 'Log Out'
    login user3
    expect(page).not_to have_content("Toys for Kids")
  end

  def admin_creates_item
    click_on 'Create a new Item'
    select 'Toys for Kids', from: 'Category'
    fill_in 'Name', with: 'Barbie Doll'
    fill_in 'Quantity', with: '3'
    fill_in 'Minimum Quantity', with: '1'
    click_on 'Save'
  end
end
