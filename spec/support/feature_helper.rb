module FeatureHelper
  def login(user = create(:user))
    login_as user, scope: :user
    user
  end

  def admin_login(admin_user = create(:admin_user))
    login_as admin_user, scope: :admin_user
    admin_user
  end
end
