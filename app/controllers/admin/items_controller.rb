module Admin
  class ItemsController < Admin::ApplicationController

    def index
      @items = Item.all
    end

    def new
      @item = Item.new
    end

    def create
      @item = Item.create(item_params)

      if @item.save
        redirect_to admin_items_path, notice: 'Item successfully created'
      else
        render :new
      end
    end

    def sell
      @item = Item.find(params[:id])
    end

    def update_sale
      @item = Item.find(params[:id])
      @item.quantity = @item.quantity - (params[:item][:quantity_sold]).to_i

      if @item.save
        redirect_to admin_items_path,
        notice: "You just sold #{params[:item][:quantity_sold]} piece(s) of #{@item.name}"
      else
        redirect_to sell_admin_item_path,
        notice: "Quantity sold should be less than the available stock"
      end
    end

    def show
    end

    def edit
      @item = Item.find(params[:id])
    end

    def update
      @item = Item.find(params[:id])

      if @item.update_attributes(item_params)
        redirect_to admin_items_path,
        notice: "'#{params[:item][:name]}' has been successfully updated"
      else
        render :edit
      end
    end

    def destroy
    end

    private

    def item_params
      params.require(:item).permit(:category, :name, :quantity, :min_qty, :quantity_sold)
    end
  end
end
