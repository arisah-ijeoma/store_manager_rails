module Admin
  class ItemsController < Admin::ApplicationController

    before_action :find_item, except: [:index, :new, :create]

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
    end

    def update_sale
      qty_sold = (params[:item][:quantity_sold])

      @item.quantity = @item.quantity - qty_sold.to_i

      if @item.save
        if qty_sold.to_i == 0
          redirect_to admin_items_path, notice: "No sale"
        else
          redirect_to admin_items_path,
          notice: "You just sold #{qty_sold} piece(s) of #{@item.name}"
        end
      else
        redirect_to sell_admin_item_path,
        notice: "Quantity sold should be less than the available stock"
      end
    end

    def edit
    end

    def update
      if @item.update_attributes(item_params)
        redirect_to admin_items_path,
        notice: "'#{params[:item][:name]}' has been successfully updated"
      else
        render :edit
      end
    end

    def destroy
      @item.destroy
      redirect_to admin_items_path,
      notice: "This item has been successfully deleted"
    end

    private

    def item_params
      params.require(:item).permit(:category, :name, :quantity, :min_qty, :quantity_sold)
    end

    def find_item
      @item = Item.find(params[:id])
    end
  end
end
