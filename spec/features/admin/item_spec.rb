require 'rails_helper'

describe "Admin Item Actions", type: :feature do
  let(:admin_user) { create(:admin_user) }

  before do
    given_i_visit_the_app
  end

  def given_i_visit_the_app
    visit admin_root_path
  end

  scenario "admin can create item" do
    click_on 'Create a new Item'
    when_i_fill_in_item_details
    expect(page).to have_content('Item successfully created')
  end

  before do
    create(:item)
    admin_login admin_user
  end

  scenario "admin can sell valid item" do
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 2
    click_on 'Sold'
    expect(page).to have_content("You just sold 2 piece(s) of Cassette")
  end

  scenario "admin can not sell wrong quantity of item" do
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 4
    click_on 'Sold'
    expect(page).to have_content("Quantity sold should be less than the available stock")
  end

  scenario "admin can not sell without new sale value" do
    click_on 'Sell'
    click_on 'Sold'
    expect(page).to have_content('No sale')
  end

  scenario "admin can update item" do
    click_on 'Edit'
    select 'Fashion', from: 'Category'
    click_on 'Save'
    expect(page).not_to have_content("Music")
    expect(page).to have_content("Fashion")
    expect(page).to have_content("'Cassette' has been successfully updated")
  end

  scenario "admin can delete item" do
    click_on 'Delete'
    expect(page).not_to have_content("Music")
    expect(page).to have_content("This item has been successfully deleted")
  end

  scenario "admin can not set minimum quantity to 0" do
    click_on 'Edit'
    fill_in 'Minimum Quantity', with: 0
    click_on 'Save'
    expect(page).to have_content('should not be 0')
  end

  def when_i_fill_in_item_details
    select 'Games', from: 'Category'
    fill_in 'Name', with: 'Mortal Kombat X'
    fill_in 'Quantity', with: '30'
    fill_in 'Minimum Quantity', with: '10'
    click_on 'Save'
  end
end
