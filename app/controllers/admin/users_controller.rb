module Admin
  class UsersController < Admin::ApplicationController
    before_action :get_admin

    load_and_authorize_resource class: "User"

    def index
      @users = @admin_user.users
    end

    def new
      @user = @admin_user.users.new
    end

    def create
      @user = @admin_user.users.create(user_params)

      if @user.save
        redirect_to admin_users_path, notice: "A new Employee has been successfully created"
      else
        render :new
      end
    end

    def edit
    end

    def update
      params[:user].delete(:password) if params[:user][:password].blank
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?

      if @user.update_attributes(user_params)
        redirect_to admin_users_path,
        notice: "Your Employee has been successfully updated" # use names
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_items_path,
      notice: "Your Employee has been successfully deleted" # use names
    end

    private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
    end
  end
end
