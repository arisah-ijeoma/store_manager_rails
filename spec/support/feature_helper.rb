module FeatureHelper

  def login(a)
    fill_in 'user_email', with: a.email
    fill_in 'user_password', with: a.password
    click_button 'Log in'
  end

  def admin_login(a)
    fill_in 'admin_user_email', with: a.email
    fill_in 'admin_user_password', with: a.password
    click_button 'Log in'
  end
end
