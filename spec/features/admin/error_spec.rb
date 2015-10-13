require 'rails_helper'

describe "Error Page", type: :feature do
  let(:admin_user) { create(:admin_user) }

  scenario "app does not raise an error" do
    visit admin_root_path
    admin_login admin_user

    visit 'admin/items/new/test'
    expect(page).to have_content('Return to app')
  end
end
