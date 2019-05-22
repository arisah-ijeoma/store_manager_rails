class AddQuantitySoldToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :quantity_sold, :integer, null: false, default: 0
  end
end
