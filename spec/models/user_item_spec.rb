require 'rails_helper'

describe UserItem do
  let(:user) { create(:user) }
  let(:item) { create(:item) }

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :item}
  end

  context "User" do
    it "has many items" do
      item_1 = create(:item)

      user.items <<  [item, item_1]

      expect(user.items.count).to eq 2
      expect(user.items).to include(item)
    end
  end

  context "Item" do
    it "has many users" do
      user_1 = create(:user)

      item.users <<  [user, user_1]

      expect(item.users.count).to eq 2
      expect(item.users).to include(user_1)
    end
  end
end
