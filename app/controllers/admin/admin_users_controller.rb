module Admin
  class AdminUsersController < Admin::ApplicationController
    load_and_authorize_resource class: "AdminUser"

    def index
      @admin_users = AdminUser.regular_admins
    end

    def new
      @admin_user = AdminUser.new
    end

    def create
      @admin_user = AdminUser.create(admin_user_params)

      if @admin_user.save
        redirect_to admin_admin_users_path, notice: "Admin successfully created"
      else
        render :new
      end
    end

    def edit
    end

    def update
      params[:admin_user].delete(:password) if params[:admin_user][:password].blank?
      params[:admin_user].delete(:password_confirmation) if params[:admin_user][:password_confirmation].blank?

      if @admin_user.update_attributes(admin_user_params)
        redirect_to admin_admin_users_path,
        notice: "Admin user has been successfully updated" # use names
      else
        render :edit
      end
    end

    def destroy
      @admin_user.destroy
      redirect_to admin_items_path,
      notice: "Admin user has been successfully deleted" # use names
    end

    private

    def admin_user_params
      params.require(:admin_user).permit(:email, :password, :password_confirmation, :role, :first_name, :last_name, :establishment)
    end
  end
end
