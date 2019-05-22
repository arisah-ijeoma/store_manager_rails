class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :item_id
      t.integer :admin_user_id

      t.timestamps null: false
    end
  end
end
