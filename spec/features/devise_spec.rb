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
end
