class AddEstablishmentToAdminUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_users, :establishment, :string, default: "", null: false
  end
end
