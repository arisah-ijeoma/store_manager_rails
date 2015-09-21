class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  private

  def current_user
    return @_logged_in_user if defined?(@_logged_in_user)
    warden = request.env["warden"]
    @_logged_in_user = warden && warden.user(:user)
  end
  helper_method :current_user

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  protected

  def initialize_omniauth_state
    session['omniauth.state'] = response.headers['X-CSRF-Token'] = form_authenticity_token
  end


  def authenticate_user!
    if current_admin_user
      unless request.original_url.include?('/admin')
        redirect_to admin_root_path, notice: "You are not authorized to view this page"
      end
    else
      super
    end
  end
end
