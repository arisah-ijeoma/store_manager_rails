class AddNewQuantitiesToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :initial_qty, :integer, null: false, default: 0
    add_column :items, :sold_qty, :integer, null: false, default: 0
    add_column :items, :added_qty, :integer, null: false, default: 0
  end
end
