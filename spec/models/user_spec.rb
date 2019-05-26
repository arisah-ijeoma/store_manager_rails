require 'rails_helper'

describe User, type: :model do
  let(:user) { create(:user) }

  describe "valid user" do
    it "has a password" do
      expect(user.password).to eq("password")
    end
  end

  describe "times out after 30 minutes" do
    it do
      expect(user.timedout?(28.minutes.ago)).to be false
      expect(user.timedout?(31.minutes.ago)).to be true
    end
  end
end
