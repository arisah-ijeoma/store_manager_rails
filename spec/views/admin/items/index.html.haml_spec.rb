require 'rails_helper'

describe "admin/items/index.html.haml" do

  before do
    allow(view).to receive(:params).and_return({sort_by: "me"})
    assign(:items, [])
  end

  describe "search returns no result" do
    it do
      render
      expect(rendered).to have_content("No item matches your search")
    end
  end

  describe "clear query button" do
    it "displays the button when any query is used" do
      render
      expect(rendered).to have_content("Clear Query")
    end
  end
end
