require 'rails_helper'

describe "Admin User Actions", type: :feature do
  let(:admin_user) { create(:admin_user) }
  let(:super_admin) { create(:super_admin_user) }

  context "General Testing" do
    before do
      visit admin_root_path
      admin_login admin_user
    end

    scenario "admin can not view user platform" do
      visit items_path
      then_i_should_hit_an_error
    end

    def then_i_should_hit_an_error
      expect(page).to have_content('You are not authorized to view this page')
    end
  end

  context "Regular Admin User" do
    before do
      visit admin_root_path
      admin_login admin_user
    end

    scenario "admin user can create new items" do
      i_should_be_able_to_create_an_item
    end

    def i_should_be_able_to_create_an_item
      expect(page).to have_content('Create a new Item')
    end
  end

  context "Super Admin User" do

    before do
      visit admin_root_path
      admin_login super_admin
    end

    scenario "super admin user can create other admin users" do
      super_admin_can_create_regular_admin
    end

    scenario "created admin has access" do
      super_admin_can_create_regular_admin
      when_i_log_out
      and_log_in_as_the_new_admin
      then_i_should_have_access
    end

    scenario "super admin user can update other admin users" do
      super_admin_can_update_regular_admin
    end

    scenario "previous admin does not have access" do
      super_admin_can_update_regular_admin
      when_i_log_out
      and_log_in_as_the_new_admin
      then_i_should_not_have_access
    end

    scenario "updated admin has access" do
      super_admin_can_update_regular_admin
      when_i_log_out
      and_log_in_as_the_updated_admin
      then_i_should_have_access
    end

    scenario "super admin can delete regular admins" do
      given_there_is_a_regular_admin
      when_i_delete_him
      then_he_should_not_be_available
    end

    def super_admin_can_create_regular_admin
      when_i_create_a_new_admin
      then_i_should_see_him
    end

    def super_admin_can_update_regular_admin
      super_admin_can_create_regular_admin
      when_i_update_the_admin
      then_i_should_see_the_updated_details
    end

    def when_i_create_a_new_admin
      click_on 'View Admins'
      click_on 'Create a new Admin'
      fill_in 'Email', with: 'jay@admin.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Save'
    end

    def then_i_should_see_him
      expect(page).to have_content('jay@admin.com')
      expect(page).to have_content('Edit')
    end

    def when_i_log_out
      click_on 'Log Out'
    end

    def and_log_in_as_the_new_admin
      fill_in 'Email', with: 'jay@admin.com'
      fill_in 'Password', with: 'password'
      click_on 'Log in'
    end

    def then_i_should_have_access
      expect(page).to have_content('Create a new Item')
      expect(page).not_to have_content('View Admins')
    end

    def when_i_update_the_admin
      click_on 'Edit'
      fill_in 'Email', with: 'jay@ad.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Save'
    end

    def then_i_should_see_the_updated_details
      expect(page).to have_content('jay@ad.com')
      expect(page).to have_content('Edit')
    end

    def then_i_should_not_have_access
      expect(page).to have_content("Invalid email or password")
    end

    def and_log_in_as_the_updated_admin
      fill_in 'Email', with: 'jay@ad.com'
      fill_in 'Password', with: 'password'
      click_on 'Log in'
    end

    def given_there_is_a_regular_admin
      super_admin_can_create_regular_admin
      expect(page).to have_content("jay@admin.com")
    end

    def when_i_delete_him
      click_on 'Delete'
    end

    def then_he_should_not_be_available
      expect(page).to have_content("Admin user has been successfully deleted")
      expect(page).not_to have_content("jay@admin.com")
    end
  end
end
