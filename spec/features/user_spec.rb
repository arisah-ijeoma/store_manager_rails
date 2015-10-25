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

  scenario "user can edit some details" do
    user_first_update
  end

  scenario "nick changes to email if not available" do
    user_first_update
    click_on "Hakuna Matata"
    fill_in "Nickname", with: ""
    click_on 'Save'
    expect(page).to have_content("Hi #{user.email}")
    expect(page).not_to have_content("Hi Hakuna Matata")
  end

  def given_i_log_in
    visit root_path
    login user
  end

  def then_i_should_not_be_able_to_create_an_item
    expect(page).not_to have_content('Create a new Item')
    expect(page).to have_content('Log Out')
  end

  def user_first_update
    given_i_log_in
    and_edit_my_nick
    then_i_should_be_updated
  end

  def then_i_should_hit_an_error
    expect(page).to have_content('You are not authorized to view this page')
  end

  def and_edit_my_nick
    click_on user.email
    fill_in 'Nickname', with: 'Hakuna Matata'
    click_on 'Save'
  end

  def then_i_should_be_updated
    expect(page).to have_content('You have been updated')
    expect(page).to have_content('Hi Hakuna Matata')
    expect(page).not_to have_content("Hi #{user.email}")
  end
end
