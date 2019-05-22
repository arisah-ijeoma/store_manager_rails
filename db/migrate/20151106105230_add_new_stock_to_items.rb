class AddNewStockToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :new_stock, :integer, null: false, default: 0
  end
end
