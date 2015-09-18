require 'rails_helper'

describe "Admin User Actions", type: :feature do
  let(:admin_user) { create(:admin_user) }

  context "Regular Admin User" do
    scenario "admin user can create new items" do
      given_i_log_in
      then_i_should_be_able_to_create_an_item
    end

    def given_i_log_in
      visit admin_root_path
      admin_login admin_user
    end

    def then_i_should_be_able_to_create_an_item
      expect(page).to have_content('Create a new Item')
    end
  end

  context "Super Admin User" do

  end
end
