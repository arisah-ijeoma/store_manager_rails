class ItemsController < ApplicationController
  before_action :get_user

  def index
    @user_items = @user.admin_user.items
    @item_decorator = ItemDecorator.new(@user_items)
    @items = @item_decorator.list_items(params[:q], params[:sort_by], params[:filter_by])
    @items = @items.order(updated_at: :desc) unless @items.empty?
  end

  def sell
    @item = Item.find(params[:id])
  end

  def update_sale
    @item = Item.find(params[:id])

    qty_sold = (params[:item][:quantity_sold]).to_i

    if qty_sold >= 0

      @item.quantity = @item.quantity - qty_sold

      if @item.save && qty_sold == 0

        redirect_to items_path, notice: "No sales made"

      elsif @item.save
        Transaction.create(admin_user: @user.admin_user, user: @user, item: @item, quantity_sold: qty_sold)

        redirect_to items_path,
                    notice: "You just sold #{qty_sold} piece(s) of #{@item.name}"
      else
        redirect_to sell_item_path,
                    notice: "Quantity sold should be less than the available stock"
      end
    else
      flash[:alert] = "Invalid Quantity"
      render :sell
    end
  end
end
