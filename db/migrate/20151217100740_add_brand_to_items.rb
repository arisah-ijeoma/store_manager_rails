class AddBrandToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :brand, :string, null: false, default: ''
  end
end
