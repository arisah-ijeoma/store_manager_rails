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

  context "invalid item" do
    describe "minimum quantity larger than quantity" do
      it "raises an error" do
        expect{
          create(:invalid_item)
        }.to raise_error("Validation failed: Min qty should be less than quantity added")
      end
    end

    describe  "invalid characters" do
      it "raises an error" do
        expect{
          create(:invalid_item_value)
        }.to raise_error("Validation failed: Quantity is not a number")
      end
    end
  end
end
