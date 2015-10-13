class AddMinQtyToItem < ActiveRecord::Migration
  def change
    add_column :items, :min_qty, :integer, null: false
  end
end
