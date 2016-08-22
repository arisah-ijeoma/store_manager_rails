module Admin
  class TransactionsController < Admin::ApplicationController

    load_and_authorize_resource class: 'Transaction'

    before_action :get_admin, :set_initial_quantity

    def index
      @transactions = Transaction.where(admin_user: @admin_user).order(updated_at: :desc)
    end

    def sales_today
      @transactions = Transaction.where(admin_user: @admin_user).daily.order(updated_at: :desc)
    end

    private

    def set_initial_quantity
      item = Item.find_by(id: params[:id])
      InitialQuantityWorker.perform_async(item.try(:id))
    end
  end
end
