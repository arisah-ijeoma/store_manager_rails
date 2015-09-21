class AddMinQtyToItem < ActiveRecord::Migration
  def change
    add_column :items, :min_qty, :integer
  end
end
