class ProfilesController < ApplicationController
  before_action :get_user
  before_action :set_profile

  def show
  end

  def edit
  end

  def update
    if params[:profile][:user_attributes][:password].blank?
      params[:profile][:user_attributes].delete(:password)
    end

    if params[:profile][:user_attributes][:password].blank?
      params[:profile][:user_attributes].delete(:password_confirmation)
    end

    if @profile.update_attributes(profile_params)
      redirect_to @profile, notice: "Successfully updated profile"
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile)
        .permit(:mobile_number,
                :phone_number,
                :salutation,
                user_attributes: [
                    :id,
                    :email,
                    :first_name,
                    :last_name,
                    :password,
                    :password_confirmation,
                    :nick
                ])
  end

  def set_profile
    @profile = @user.profile
  end
end
