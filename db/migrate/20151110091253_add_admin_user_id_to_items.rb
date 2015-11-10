class AddAdminUserIdToItems < ActiveRecord::Migration
  def change
    add_reference :items, :admin_user, index: true, foreign_key: true
  end
end
