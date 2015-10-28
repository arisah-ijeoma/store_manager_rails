class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
