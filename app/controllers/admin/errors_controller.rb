module Admin
  class ErrorsController < Admin::ApplicationController
    def show
      render_admin_error_page
    end
  end
end
