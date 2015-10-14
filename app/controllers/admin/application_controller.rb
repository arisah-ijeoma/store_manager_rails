module Admin
  class ApplicationController < ActionController::Base
    layout :layout_by_resource_admin

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

    def render_admin_error_page(exception = nil)
      if exception
        logger.info "Rendering #{status_code}: #{exception.message}"
      end

      render file: "errors/#{status_code}.html", :status => status_code, :layout => false
    end

    protected

    def layout_by_resource_admin
      if devise_controller?
        "devise"
      else
        "admin"
      end
    end

    def status_code
      params[:code] || 500
    end

    def authenticate_admin_user!
      if current_user
        redirect_to root_path, notice: "You are not authorized to view this page"
      else
        super
      end
    end
  end
end
