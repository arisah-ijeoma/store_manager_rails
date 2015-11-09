class AddNewStockToItems < ActiveRecord::Migration
  def change
    add_column :items, :new_stock, :integer, null: false, default: 0
  end
end
