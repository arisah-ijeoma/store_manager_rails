require 'rails_helper'

describe 'User Item Actions', type: :feature do
  let(:user) { create(:user) }

  before do
    # only admins can create items
    visit admin_root_path
    create(:item)

    visit root_path
    login user
  end

  scenario "user can see all items" do
    expect(page).to have_content("Music")
  end

  scenario "user can sell item" do
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 2
    click_on 'Sold'
    expect(page).to have_content("You just sold 2 piece(s) of Cassette")
  end

  scenario "user can not sell wrong quantity of item" do
    click_on 'Sell'
    fill_in 'Quantity Sold', with: 4
    click_on 'Sold'
    expect(page).to have_content("Quantity sold should be less than the available stock")
  end
end
