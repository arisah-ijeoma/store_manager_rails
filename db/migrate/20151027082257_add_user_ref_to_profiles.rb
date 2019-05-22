class AddUserRefToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_reference :profiles, :user, index: true, foreign_key: true
  end
end
