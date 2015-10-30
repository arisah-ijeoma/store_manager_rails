require 'rails_helper'

describe "Admin User Actions", type: :feature do
  let(:admin_user1) { create(:admin_user) }
  let(:admin_user2) { create(:admin_user, establishment: "Mount Everest") }
  let(:super_admin) { create(:super_admin_user) }

  context "General Testing" do
    before do
      visit admin_root_path
      admin_login admin_user1
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
      admin_login admin_user1
    end

    scenario "admin user can create new items" do
      i_can_create_an_item
    end

    scenario "admin user can create employees" do
      admin_can_create_employee
    end

    scenario "created employee has access" do
      admin_can_create_employee
      when_i_sign_out
      and_log_in_as_new_employee
      then_i_should_be_logged_in
    end

    scenario "admin can update employee" do
      admin_can_update_employee
    end

    scenario "previous employee details won't work" do
      admin_can_update_employee
      when_i_sign_out
      and_log_in_with_old_details
      then_i_should_not_be_logged_in
    end

    scenario "updated employee has access" do
      admin_can_update_employee
      when_i_sign_out
      and_log_in_with_new_details
      then_i_should_exist
    end

    scenario "admin can delete employee" do
      given_there_is_an_employee
      when_i_delete
      then_he_should_not_exist
    end

    scenario "another admin can not see my employee" do
      admin_can_create_employee
      when_i_sign_out
      and_log_in_as_another_admin
      then_i_should_not_see_any_employee
    end

    def i_can_create_an_item
      expect(page).to have_content('Create a new Item')
    end

    def admin_can_create_employee
      when_i_create_a_new_employee
      then_he_should_exist
    end

    def when_i_create_a_new_employee
      visit new_admin_user_path
      fill_in 'Email', with: 'jay@user.com'
      fill_in 'First name', with: 'Yeko'
      fill_in 'Last name', with: 'Yeko'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Save'
    end

    def then_he_should_exist
      expect(page).to have_content("A new Employee has been successfully created")
      expect(page).to have_content("You have 1 employee(s)")
    end

    def when_i_sign_out
      click_on 'Log Out'
    end

    def and_log_in_as_new_employee
      click_on 'Log in as User'
      fill_in 'user_email', with: 'jay@user.com'
      fill_in 'user_password', with: 'password'
      click_on 'Log in'
    end

    def then_i_should_be_logged_in
      expect(page).to have_content('Yeko Yeko')
      expect(page).to have_content('Cookie Bar')
    end

    def admin_can_update_employee
      admin_can_create_employee
      when_i_update_the_employee
      then_he_should_be_available
    end

    def when_i_update_the_employee
      click_on 'Edit'
      fill_in 'Email', with: 'jay@us.com'
      click_on 'Save'
    end

    def then_he_should_be_available
      expect(page).to have_content("You have successfully updated your employee")
      expect(page).to have_content('jay@us.com')
      expect(page).to have_content('Edit')
    end

    def and_log_in_with_old_details
      click_on 'Log in as User'
      fill_in 'user_email', with: 'jay@user.com'
      fill_in 'user_password', with: 'password'
      click_on 'Log in'
    end

    def then_i_should_not_be_logged_in
      expect(page).to have_content("Invalid email or password")
    end

    def and_log_in_with_new_details
      click_on 'Log in as User'
      fill_in 'user_email', with: 'jay@us.com'
      fill_in 'user_password', with: 'password'
      click_on 'Log in'
    end

    def then_i_should_exist
      expect(page).to have_content('Yeko Yeko')
    end

    def given_there_is_an_employee
      admin_can_create_employee
      expect(page).to have_content('jay@user.com')
    end

    def when_i_delete
      click_on 'Delete'
    end

    def then_he_should_not_exist
      expect(page).to have_content("You have successfully deleted your employee")
      expect(page).not_to have_content("jay@user.com")
    end

    def and_log_in_as_another_admin
      admin_login admin_user2
    end

    def then_i_should_not_see_any_employee
      expect(page).not_to have_content('jay@user.com')
    end
  end

  context "Super Admin User" do

    before do
      visit admin_root_path
      admin_login super_admin
    end

    scenario "super admin user can create other admin users" do
      super_can_create_regular_admin
    end

    scenario "created admin has access" do
      super_can_create_regular_admin
      when_i_log_out
      and_log_in_as_the_new_admin
      then_i_should_have_access
    end

    scenario "super admin user can update other admin users" do
      super_can_update_regular_admin
    end

    scenario "previous admin does not have access" do
      super_can_update_regular_admin
      when_i_log_out
      and_log_in_as_the_new_admin
      then_i_should_not_have_access
    end

    scenario "updated admin has access" do
      super_can_update_regular_admin
      when_i_log_out
      and_log_in_as_the_updated_admin
      then_i_should_have_access
    end

    scenario "super admin can delete regular admins" do
      given_there_is_a_regular_admin
      when_i_delete_him
      then_he_should_not_be_available
    end

    scenario "super admin can view regular admin's employees" do
      super_creates_regular_that_creates_employee
      click_on 'Log Out'
      admin_login super_admin
      visit admin_admin_user_path(@admin_user)
      click_on "#{@admin_user.admin_full_name}'s Employees"
      expect(page).to have_content("#{@admin_user.admin_full_name}'s Employees")
      expect(page).to have_content("The client has 1 employee(s)")
      expect(page).to have_content("jay@user.com")
    end

    def super_can_create_regular_admin
      when_i_create_a_new_admin
      then_i_should_see_him
    end

    def super_can_update_regular_admin
      super_can_create_regular_admin
      when_i_update_the_admin
      then_i_should_see_the_new_details
    end

    def when_i_create_a_new_admin
      click_on 'View Admins'
      click_on 'Create a new Admin'
      fill_in 'Email', with: 'jay@admin.com'
      fill_in 'First name', with: 'Jay'
      fill_in 'Last name', with: 'Jay'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      fill_in 'Establishment', with: 'Alphacomm'
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
      fill_in 'admin_user_email', with: 'jay@admin.com'
      fill_in 'admin_user_password', with: 'password'
      click_on 'Log in'
    end

    def then_i_should_have_access
      expect(page).to have_content('Create a new Item')
      expect(page).not_to have_content('View Admins')
    end

    def when_i_update_the_admin
      click_on 'Edit'
      fill_in 'Email', with: 'jay@ad.com'
      click_on 'Save'
    end

    def then_i_should_see_the_new_details
      expect(page).to have_content('jay@ad.com')
      expect(page).to have_content('Jay Jay has been successfully updated')
      expect(page).to have_content('Edit')
    end

    def then_i_should_not_have_access
      expect(page).to have_content("Invalid email or password")
    end

    def and_log_in_as_the_updated_admin
      fill_in 'admin_user_email', with: 'jay@ad.com'
      fill_in 'admin_user_password', with: 'password'
      click_on 'Log in'
    end

    def given_there_is_a_regular_admin
      super_can_create_regular_admin
      expect(page).to have_content("jay@admin.com")
    end

    def when_i_delete_him
      click_on 'Delete'
    end

    def then_he_should_not_be_available
      expect(page).to have_content("Jay Jay has been successfully deleted")
      expect(page).to have_content("There are currently 0 client(s) on the platform")
      expect(page).not_to have_content("jay@admin.com")
    end

    def super_creates_regular_that_creates_employee
      given_i_create_a_regular_admin
      when_i_log_out
      and_log_in_as_the_regular_admin
      then_he_creates_an_employee
    end

    def given_i_create_a_regular_admin
      @admin_user = create(:admin_user)
    end

    def and_log_in_as_the_regular_admin
      admin_login @admin_user
    end

    def then_he_creates_an_employee
      visit new_admin_user_path
      fill_in 'Email', with: 'jay@user.com'
      fill_in 'First name', with: 'Yeko'
      fill_in 'Last name', with: 'Yeko'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Save'
    end
  end
end
