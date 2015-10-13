require 'rails_helper'

describe "Error Page", type: :feature do
  let(:user) { create(:user) }

  scenario "app does not raise an error" do
    visit root_path
    login user

    visit '/items/new'
    expect(page).to have_content('Return to app')
  end
end
