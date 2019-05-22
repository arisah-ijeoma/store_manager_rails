class AddQuantitySoldToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :quantity_sold, :integer, null: false, default: 0
  end
end
