class CreateUserItems < ActiveRecord::Migration[5.1]
  def change
    create_table :user_items do |t|
      t.references :user, index: true
      t.references :item, index: true

      t.timestamps
    end
  end
end
