require 'rails_helper'

describe "Admin Profile", type: :feature do

  let(:admin_user) { create(:admin_user) }

  before do
    visit admin_root_path
    admin_login admin_user
  end

  scenario "Profile is created on admin creation" do
    visit admin_profile_path
    expect(page).to have_content("Jay Jay")
    expect(page).to have_content("Edit Profile")
  end

  scenario "Profile can be updated" do
    visit admin_profile_path
    click_on "Edit Profile"
    fill_in 'First name', with: 'Jax'
    click_on 'Save'
    expect(page).to have_content("Jax Jay")
  end

  scenario "Profile can be accessed from header (name)" do
    click_on 'Jay Jay'
    expect(page).to have_content("Jay Jay")
    expect(page).to have_content("Edit Profile")
  end

  scenario "Admin can access his employee's profile" do
    given_the_admin_has_an_employee
    when_the_admin_clicks_on_his_employee
  end

  def given_the_admin_has_an_employee
    @employee = create(:user, admin_user: admin_user)
  end

  def when_the_admin_clicks_on_his_employee
    visit admin_users_path
    click_on "#{@employee.email}"
    expect(page).to have_content("#{@employee.full_name}'s Profile")
  end
end
