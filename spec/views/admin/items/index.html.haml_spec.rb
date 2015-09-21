require 'rails_helper'

describe "admin/items/index.html.haml" do
  let(:admin_user) { create(:admin_user) }

  before do
    allow(view).to receive(:current_admin_user) { admin_user }
  end

  it do
    render
    expect(rendered).to have_content("Create a new Item")
  end
end
