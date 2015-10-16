require 'rails_helper'

describe "Devise", type: :feature do
  scenario "admin user log in page" do
    visit new_admin_user_session_path
    expect(page).to have_content('Log in as User')
  end

  scenario "user log in page" do
    visit new_user_session_path
    expect(page).to have_content('Log in as Admin')
  end

  scenario "admin login error sill shows user option" do
    visit new_admin_user_session_path
    fill_details
    expect(page).to have_content('Log in as User')
  end

  scenario "user login error sill shows admin option" do
    visit new_user_session_path
    fill_details
    expect(page).to have_content('Log in as Admin')
  end

  def fill_details
    fill_in 'Email', with: 'x.com'
    fill_in 'Password', with: 'x.comske'
    click_on 'Log in'
  end
end
