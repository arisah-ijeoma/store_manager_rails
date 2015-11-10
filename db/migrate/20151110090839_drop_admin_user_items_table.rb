class DropAdminUserItemsTable < ActiveRecord::Migration
  def change
    drop_table :admin_user_items
  end
end
