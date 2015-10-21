class AddEstablishmentToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :establishment, :string, default: "", null: false
  end
end
