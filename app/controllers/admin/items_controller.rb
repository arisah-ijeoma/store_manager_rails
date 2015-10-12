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

    def edit
    end

    def show
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

    def update
    end

    def destroy
    end

    private

    def item_params
      params.require(:item).permit(:category, :name, :quantity, :min_qty, :quantity_sold)
    end
  end
end
