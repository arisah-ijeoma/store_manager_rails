require 'rails_helper'

describe "User Actions", type: :feature do
  let(:user) { create(:user) }


  scenario "user can not create new items" do
    given_i_log_in
    then_i_should_not_be_able_to_create_an_item
  end

  scenario "user can not view admin platform" do
    given_i_log_in
    visit admin_items_path
    then_i_should_hit_an_error
  end

  def given_i_log_in
    visit root_path
    login user
  end

  def then_i_should_not_be_able_to_create_an_item
    expect(page).not_to have_content('Create a new Item')
    expect(page).to have_content('Log Out')
  end

  def then_i_should_hit_an_error
    expect(page).to have_content('You are not authorized to view this page')
  end
end
