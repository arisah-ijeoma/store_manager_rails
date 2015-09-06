require 'rails_helper'

describe Devise::SessionsController do

  render_views

  describe "valid user" do
    it "logs in" do
      user = FactoryGirl.create(:user)
      sign_in user

      expect(response).to be_success
    end
  end
end
