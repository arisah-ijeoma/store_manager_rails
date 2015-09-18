class ItemsController < ApplicationController
  load_and_authorize_resource class: 'Item'

  def index
    # binding.pry
    @items = Item.all
    # authorize! :read, @items
  end

  def new
    @item = Item.new
    # authorize! :new, @item
  end

  def create
    @item = Item.create(item_params)

    if @item.save
      redirect_to items_path, notice: 'Item successfully added'
    else
      render :new
    end

    # authorize! :create, @item
  end

  def edit
    # authorize! :edit, @item
  end

  def show
    # authorize! :show, @item
  end

  def update
    # authorize! :update, @item
  end

  def destroy
    # authorize! :destroy, @item
  end

  private

  def item_params
    params.require(:item).permit(:category, :name, :quantity, :min_quantity)
  end
end
