require 'rails_helper'

describe Item do
  context "associations" do
    it {is_expected.to have_many :admin_users}
    it {is_expected.to have_many :admin_user_items}
  end

  describe "valid item" do
    it "has a category" do
      item = create(:item)
      expect(item.category).to eq("Music")
    end
  end
end
