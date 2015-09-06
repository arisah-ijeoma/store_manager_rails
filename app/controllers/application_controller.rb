class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  before_action :initialize_omniauth_state
  protect_from_forgery with: :exception

  private

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  protected

  def initialize_omniauth_state
    session['omniauth.state'] = response.headers['X-CSRF-Token'] = form_authenticity_token
  end
end
