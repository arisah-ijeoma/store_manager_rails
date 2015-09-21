module Admin
  class ApplicationController < ActionController::Base
    layout 'admin'

    before_action :authenticate_admin_user!
    protect_from_forgery

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to admin_root_path, alert: exception.message
    end

    private

    def current_admin_user
      return @_logged_in_admin_user if defined?(@_logged_in_admin_user)
      warden = request.env["warden"]
      @_logged_in_admin_user = warden && warden.user(:admin_user)
    end
    helper_method :current_admin_user


    def current_ability
      @current_ability ||= Ability.new(current_admin_user)
    end

    protected

    def authenticate_admin_user!
      if current_user
        redirect_to root_path, notice: "You are not authorized to view this page"
      else
        super
      end
    end
  end
end
