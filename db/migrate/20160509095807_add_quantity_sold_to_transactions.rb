class AddQuantitySoldToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :quantity_sold, :integer, null: false, default: 0
  end
end
