class AddMinQuantityToItem < ActiveRecord::Migration
  def change
    add_column :items, :min_quantity, :integer
  end
end
