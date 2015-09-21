class Admin::SessionsController < Devise::SessionsController
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
end
