module Admin
  class ApplicationController < ActionController::Base
    layout 'admin'

    before_action :authenticate_admin_user!
    protect_from_forgery
  end
end
