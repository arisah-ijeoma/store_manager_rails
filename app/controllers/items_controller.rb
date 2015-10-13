class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def sell
    @item = Item.find(params[:id])
  end

  def update_sale
    @item = Item.find(params[:id])

    @item.quantity = @item.quantity - (params[:item][:quantity_sold]).to_i

    if @item.save
      redirect_to items_path,
                  notice: "You just sold #{params[:item][:quantity_sold]} piece(s) of #{@item.name}"
    else
      redirect_to sell_item_path,
                  notice: "Quantity sold should be less than the available stock"
    end
  end
end
