class AddNameToAdminUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_users, :first_name, :string, default: "", null: false
    add_column :admin_users, :last_name, :string, default: "", null: false
  end
end
