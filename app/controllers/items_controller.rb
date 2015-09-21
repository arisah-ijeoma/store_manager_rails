class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def edit
  end

  def update
  end
end
