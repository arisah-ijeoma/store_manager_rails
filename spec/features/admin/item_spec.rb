require 'rails_helper'

describe "Admin Item Actiona", type: :feature do
  let(:admin_user) { create(:admin_user) }

  before do
    given_i_visit_the_app
  end

  def given_i_visit_the_app
    visit admin_root_path
  end

  scenario "admin can create item" do
    admin_login admin_user
    click_on 'Create a new Item'
    when_i_fill_in_item_details
    expect(page).to have_content('Item successfully created')
  end

  scenario "admin can sell valid item" do
    create(:item)
    admin_login admin_user
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 2
    click_on 'Sold'
    expect(page).to have_content("You just sold 2 piece(s) of Cassette")
  end

  scenario "admin can not sell item" do
    create(:item)
    admin_login admin_user
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 4
    click_on 'Sold'
    expect(page).to have_content("Quantity sold should be less than the available stock")
  end

  def when_i_fill_in_item_details
    select 'Games', from: 'Category'
    fill_in 'Name', with: 'Mortal Kombat X'
    fill_in 'Quantity', with: '30'
    fill_in 'Minimum Quantity', with: '10'
    click_on 'Save'
  end
end
