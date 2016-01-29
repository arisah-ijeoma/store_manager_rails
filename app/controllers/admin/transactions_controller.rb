module Admin
  class TransactionsController < Admin::ApplicationController

    load_and_authorize_resource class: 'Transaction'

    before_action :get_admin

    def index
      @transactions = Transaction.where(admin_user: @admin_user).daily.order(updated_at: :desc)
    end
  end
end
