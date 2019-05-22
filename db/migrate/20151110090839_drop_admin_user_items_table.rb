class DropAdminUserItemsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :admin_user_items
  end
end
