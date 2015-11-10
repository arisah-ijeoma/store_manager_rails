require 'rails_helper'

describe "Error Page", type: :feature do
  context "Employee" do
    let(:user) { create(:user) }

    scenario "app does not raise an error" do
      visit root_path
      login user

      visit '/items/new'
      expect(page).to have_content('Return to app')
    end
  end

  context "Admin" do
    let(:admin_user) { create(:admin_user) }

    scenario "invalid record" do
      visit admin_root_path
      admin_login admin_user
      visit "admin/items/50/edit"
      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
