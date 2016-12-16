class RemoveSoldQtyFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :sold_qty
  end
end
