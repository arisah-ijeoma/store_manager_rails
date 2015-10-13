require 'rails_helper'

describe 'admin/items/edit.html.haml', type: :view do
  let(:item) { create(:item) }

  before do
    assign(:item, item)
    allow(view).to receive(:edit_admin_item_path).with(item)
  end

  it do
    render
    expect(rendered).to have_content('Music')
  end
end
