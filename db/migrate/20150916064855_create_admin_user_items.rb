class CreateAdminUserItems < ActiveRecord::Migration
  def change
    create_table :admin_user_items do |t|
      t.references :admin_user, index: true
      t.references :item, index: true

      t.timestamps
    end
  end
end
