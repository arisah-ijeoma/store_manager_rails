require 'rails_helper'

describe "Omniauth Callbacks", type: :feature do

  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  scenario "Google Authentication" do
    given_i_sign_in_through_google
    then_i_should_be_logged_in
  end

  def given_i_sign_in_through_google
    visit root_path
    click_on 'Sign in with Google Oauth2'
  end

  def then_i_should_be_logged_in
    expect(page).to have_content('Successfully authenticated from Google account')
  end
end
