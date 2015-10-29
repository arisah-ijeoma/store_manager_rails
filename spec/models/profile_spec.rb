require 'rails_helper'

describe Profile do
  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :admin_user}
  end

  describe "profile is created when user is created" do
    it do
      admin_user = create(:admin_user)
      expect(admin_user.profile).to be_truthy
    end
  end
end
