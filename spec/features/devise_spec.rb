require 'rails_helper'

describe "Devise", type: :feature do
  context "user" do
    scenario "user log in page" do
      visit new_user_session_path
      expect(page).to have_content('Log in as Admin')
    end

    scenario "user login error sill shows admin option" do
      visit new_user_session_path
      fill_details
      expect(page).to have_content('Log in as Admin')
    end

    scenario "oauth doesn't show on sign up" do
      visit new_user_registration_path
      expect(page).not_to have_content('Sign in with')
    end
  end

  context "admin" do
    scenario "admin user log in page" do
      visit new_admin_user_session_path
      expect(page).to have_content('Log in as User')
    end

    scenario "admin login error sill shows user option" do
      visit new_admin_user_session_path
      fill_details
      expect(page).to have_content('Log in as User')
    end

    scenario "sign up is no longer accessible" do
      visit '/admin_users/sign_up'
      expect(page).to have_content('Log in')
      expect(page).to have_content('Sign in with Facebook')
      expect(page).to have_content('Log in as Admin')
    end
  end

  def fill_details
    fill_in 'Email', with: 'x.com'
    fill_in 'Password', with: 'x.comske'
    click_on 'Log in'
  end
end
