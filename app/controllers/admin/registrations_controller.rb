class Admin::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected

  def after_sign_up_path_for(resource)
    admin_root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:name, :role)
  end
end
