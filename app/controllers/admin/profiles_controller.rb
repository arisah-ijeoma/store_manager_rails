module Admin
  class ProfilesController < Admin::ApplicationController

    before_action :get_admin, :set_admin_profile

    def show
    end

    def edit
    end

    def update
      if params[:profile][:admin_user_attributes][:password].blank?
        params[:profile][:admin_user_attributes].delete(:password)
      end

      if params[:profile][:admin_user_attributes][:password].blank?
        params[:profile][:admin_user_attributes].delete(:password_confirmation)
      end

      if @profile.update_attributes(profile_params)
        redirect_to [:admin, @profile], notice: "Successfully updated profile"
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
                    admin_user_attributes: [
                      :id,
                      :email,
                      :first_name,
                      :last_name,
                      :password,
                      :password_confirmation,
                      :role,
                      :establishment
                    ])
    end

    def set_admin_profile
      @profile = @admin_user.profile
    end
  end
end
