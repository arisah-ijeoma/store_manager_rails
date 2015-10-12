class AddQuantitySoldToItems < ActiveRecord::Migration
  def change
    add_column :items, :quantity_sold, :integer, null: false, default: 0
  end
end
