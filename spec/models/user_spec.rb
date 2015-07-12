require 'rails_helper'

describe User do
  describe "valid user" do
    it "has a password" do
      user = FactoryGirl.create(:user)
      expect(user.password).to eq("password")
    end
  end
end
