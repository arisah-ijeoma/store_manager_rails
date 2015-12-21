require 'rails_helper'

describe "items/index.html.haml" do

  describe "search returns no result" do
    before do
      assign(:items,[])
    end

    it do
      render
      expect(rendered).to have_content("There is no match for your search")
    end
  end
end
