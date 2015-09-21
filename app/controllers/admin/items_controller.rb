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

    def edit
    end

    def show
    end

    def update
    end

    def destroy
    end

    private

    def item_params
      params.require(:item).permit(:category, :name, :quantity, :min_qty)
    end
  end
end
