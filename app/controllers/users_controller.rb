class UsersController < ApplicationController
  before_action :get_user

  load_and_authorize_resource class: 'User'

  def edit
  end

  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?

    if @user.update_attributes(user_params)
      redirect_to items_path, notice: "You have been updated" #   use names
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :nick)
  end
end
