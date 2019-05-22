class DropUserItems < ActiveRecord::Migration[5.1]
  def change
    drop_table :user_items
  end
end
