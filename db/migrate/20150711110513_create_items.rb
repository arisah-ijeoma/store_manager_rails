class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :category,     null: false
      t.string :name,         null: false
      t.integer :quantity,    null: false

      t.timestamps
    end
  end
end
