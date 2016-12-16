module Admin
  class ItemsController < Admin::ApplicationController

    before_action :get_admin

    load_and_authorize_resource class: "Item"

    def index
      @admin_items = @admin_user.items
      @item_decorator = ItemDecorator.new(@admin_items)
      @items = @item_decorator.list_items(params[:q], params[:sort_by], params[:filter_by])
      @items = @items.order(updated_at: :desc) unless @items.empty?
    end

    def new
      @item = @admin_user.items.new
    end

    def create
      if @item.validate_min_quantity?
        @item = @admin_user.items.create(item_params)
        if @item.save
          redirect_to admin_items_path, notice: 'Item successfully created'
        else
          render :new
        end
      else
        flash[:notice] = "Minimum Quantity should be less than quantity added"
        render :new
      end
    end

    def sell
    end

    def update_sale
      qty_sold = (params[:item][:quantity_sold]).to_i

      if qty_sold >= 0
        @item.quantity = @item.quantity - qty_sold

        if @item.save && qty_sold == 0
          redirect_to admin_items_path, notice: "No sales made"
        elsif @item.save
          Transaction.create(admin_user: @admin_user, item: @item, quantity_sold: qty_sold)
          redirect_to admin_items_path,
          notice: "You just sold #{qty_sold} piece(s) of #{@item.name}"
        else
          redirect_to sell_admin_item_path,
          notice: "Quantity sold should be less than the available stock"
        end
      else
        flash[:alert] = "Invalid Quantity"
        render :sell
      end
    end

    def add_stock
    end

    def update_stock
      new_stock = (params[:item][:new_stock]).to_i

      if new_stock >= 0
        @item.quantity = @item.quantity + new_stock

        if @item.save
          if new_stock == 0
            redirect_to add_stock_admin_item_path, notice: "Please add a value for the new stock"
          else
            redirect_to edit_admin_item_path,
            notice: "You added #{new_stock} piece(s) of #{@item.name}"
          end
        else
          redirect_to edit_admin_item_path
        end
      else
        flash[:notice] = "Invalid Quantity"
        render :add_stock
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
      params.require(:item).permit(:category,
                                   :name,
                                   :quantity,
                                   :min_qty,
                                   :quantity_sold,
                                   :new_stock,
                                   :brand,
                                   :initial_qty,
                                   :added_qty)
    end
  end
end
