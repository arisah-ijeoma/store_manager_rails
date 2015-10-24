require 'rails_helper'

describe "Devise", type: :feature do
  context "user" do
    scenario "user log in page" do
      visit new_user_session_path
      expect(page).to have_content('Log in as Admin')
    end

    scenario "user login error sill shows admin option" do
      visit new_user_session_path
      fill_user_details
      expect(page).to have_content('Log in as Admin')
    end
  end

  context "admin" do
    scenario "admin user log in page" do
      visit new_admin_user_session_path
      expect(page).to have_content('Log in as User')
    end

    scenario "admin login error sill shows user option" do
      visit new_admin_user_session_path
      fill_admin_details
      expect(page).to have_content('Log in as User')
    end

    scenario "sign up is no longer accessible" do
      visit '/admin_users/sign_up'
      expect(page).to have_content('Log in')
      expect(page).to have_content('Log in as Admin')
    end
  end

  def fill_user_details
    fill_in 'user_email', with: 'x.com'
    fill_in 'user_password', with: 'x.comske'
    click_on 'Log in'
  end

  def fill_admin_details
    fill_in 'admin_user_email', with: 'x.com'
    fill_in 'admin_user_password', with: 'x.comske'
    click_on 'Log in'
  end
end
