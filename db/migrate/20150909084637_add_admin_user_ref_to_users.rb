class AddAdminUserRefToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :admin_user, index: true
  end
end
