require 'rails_helper'

describe AdminUserItem do
  let(:admin_user) { create(:admin_user) }
  let(:item) { create(:item) }

  context "associations" do
    it {is_expected.to belong_to :admin_user}
    it {is_expected.to belong_to :item}
  end

  context "AdminUser" do
    it "has many items" do
      item_1 = create(:item)

      admin_user.items <<  [item, item_1]

      expect(admin_user.items.count).to eq 2
      expect(admin_user.items).to include(item)
    end
  end

  context "Item" do
    it "has many admin users" do
      admin_user_1 = create(:admin_user)

      item.admin_users <<  [admin_user, admin_user_1]

      expect(item.admin_users.count).to eq 2
      expect(item.admin_users).to include(admin_user_1)
    end
  end
end
