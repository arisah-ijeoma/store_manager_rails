require 'rails_helper'

describe "admin/items/_item.html.haml" do
  let(:item) { create(:item) }

  it do
    render partial: 'admin/items/item.html.haml', locals: {item: item}
    expect(rendered).to have_content("Music")
  end
end
