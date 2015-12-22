require 'rails_helper'

describe Item do
  context "associations" do
    it {is_expected.to belong_to :admin_user}
  end

  context "valid items" do
    describe "has a category" do
      it do
        item = create(:item)
        expect(item.category).to eq("Music")
      end
    end

    describe "capitalizes" do
      it do
        item = create(:valid_item_name_case)
        expect(item.name).to eq("My Item Name")
      end
    end

    describe "captilizing does not affect acronyms" do
      it do
        item = create(:valid_item_name_case)
        expect(item.brand).to eq("DMX")
      end
    end

    describe "same name different brands can exist" do
      it do
        item1 = create(:valid_item_name_case)
        item2 = create(:valid_item_name_case, brand: 'Bis')
        expect(item1.brand).to eq("DMX")
        expect(item1.name).to eq("My Item Name")
        expect(item2.brand).to eq("Bis")
        expect(item2.name).to eq("My Item Name")
      end
    end

    context "brands" do
      describe "no brand" do
        it do
          item = create(:item)
          expect(item.brand).to eq("--")
        end
      end

      describe "empty brand" do
        it do
          item = create(:valid_item_empty_brand)
          expect(item.brand).to eq("--")
        end
      end
    end
  end

  context "invalid items" do
    describe  "invalid characters" do
      it "raises an error" do
        expect{
          create(:invalid_item_value)
        }.to raise_error("Validation failed: Quantity is not a number")
      end
    end

    describe "duplicate item name" do
      it "raises an error" do
        create(:item)
        expect{
          create(:item, name: 'cassette')
        }.to raise_error("Validation failed: Name This item already exists")
      end
    end

    describe "items without brands can not have the same name" do
      it do
        create(:item)
        expect{
          create(:valid_item_empty_brand)
        }.to raise_error("Validation failed: Name This item already exists")
      end
    end
  end
end
