require 'rails_helper'

describe Profile, type: :model do
  describe "profile is created when user is created" do
    it do
      admin_user = create(:admin_user)
      expect(admin_user.profile).to be_truthy
    end
  end
end
