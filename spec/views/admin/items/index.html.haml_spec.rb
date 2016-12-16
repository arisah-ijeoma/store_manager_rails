require 'rails_helper'

describe "admin/items/index.html.haml" do

  describe "search returns no result" do
    before do
      allow(view).to receive(:params).and_return({sort_by: "me"})
      assign(:items, [])
    end

    it do
      render
      expect(rendered).to have_content("No item matches your search")
    end
  end
end
