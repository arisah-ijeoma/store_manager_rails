class Admin::SessionsController < Devise::SessionsController
  # before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    admin_root_path
  end

  def after_sign_out_path_for(resource)
    new_admin_user_session_path
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_in) << :attribute
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:user) { |u| u.permit(:email, :password, :name) }
  # end
end
