require 'rails_helper'

describe User do
  context "associations" do
    it {is_expected.to belong_to :admin_user}
  end

  describe "valid user" do
    it "has a password" do
      user = create(:user)
      expect(user.password).to eq("password")
    end
  end
end
