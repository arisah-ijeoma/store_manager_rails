require 'rails_helper'

describe "Admin can sell item", type: :feature do
  let(:admin_user) { create(:admin_user) }
  let(:item) { create(:item) }

  before do
    given_i_log_in
  end

  def given_i_log_in
    visit admin_root_path
    admin_login admin_user
  end

  context "valid sale" do
    scenario "admin can sell item" do
      click_on 'Sell'
      fill_in 'Quantity Sold', with: 2
      click_on 'Sold'
      expect(page).to have_content("You just sold 2 piece(s) of Cassette")
    end
  end

  context "invalid sale" do
    scenario "admin can sell item" do
      click_on 'Sell'
      fill_in 'Quantity Sold', with: 4
      click_on 'Sold'
      expect(page).to have_content("Quantity sold should be less than the available stock")
    end
  end
end
