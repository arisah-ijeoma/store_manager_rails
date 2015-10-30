require 'rails_helper'

describe "Employee Profile", type: :feature do

  let(:admin_user) { create(:admin_user) }
  let(:employee) { create(:user, admin_user: admin_user) }

  before do
    visit root_path
    login employee
  end

  scenario "Profile is created on employee creation" do
    visit profile_path
    expect(page).to have_content("Jay Jay")
    expect(page).to have_content("Edit Profile")
  end

  scenario "Profile can be updated" do
    visit profile_path
    click_on "Edit Profile"
    fill_in 'Nick', with: 'Hiro'
    click_on 'Save'
    expect(page).to have_content("Hiro")
  end

  scenario "Profile can be accessed from header (name)" do
    click_on 'Jay Jay'
    expect(page).to have_content("Jay Jay")
    expect(page).to have_content("Edit Profile")
  end
end
