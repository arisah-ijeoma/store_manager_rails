class AddBrandToItems < ActiveRecord::Migration
  def change
    add_column :items, :brand, :string, null: false, default: ''
  end
end
