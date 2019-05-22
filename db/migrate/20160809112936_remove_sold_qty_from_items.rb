class RemoveSoldQtyFromItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :sold_qty
  end
end
