require 'rails_helper'

describe Admin::TransactionsController do

  let(:admin_user) { create(:admin_user) }

  render_views

  before do
    sign_in admin_user
  end

  describe "#index" do
    it do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "#sales_today" do
    it do
      get :sales_today
      expect(response).to have_http_status(200)
    end
  end
end
