class AddAdminUserIdToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :admin_user, index: true, foreign_key: true
  end
end
