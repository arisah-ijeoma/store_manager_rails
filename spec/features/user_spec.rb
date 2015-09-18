require 'rails_helper'

describe "User Actions", type: :feature do
  let(:user) { create(:user) }


  scenario "admin user can create new items" do
    given_i_log_in
    then_i_should_be_able_to_create_an_item
  end

  def given_i_log_in
    visit root_path
    login user
  end

  def then_i_should_be_able_to_create_an_item
    expect(page).to have_content('Log Out')
  end
end
