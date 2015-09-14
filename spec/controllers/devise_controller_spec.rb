require 'rails_helper'

describe Devise::SessionsController do

  render_views

  context "regular users" do
    describe "valid user" do
      it "logs in" do
        user = create(:user)
        sign_in user

        expect(response).to be_success
      end
    end
  end

  context "admin users" do
    context "regular admin" do
      describe "valid admin user" do
        it "logs in" do
          admin_user = create(:admin_user)
          sign_in admin_user

          expect(response).to be_success
        end
      end
    end

    context "super admin" do
      describe "valid admin user" do
        it "logs in" do
          super_admin_user = create(:super_admin_user)
          sign_in super_admin_user

          expect(response).to be_success
        end
      end
    end
  end
end
