class SalutationToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :salutation, :string
  end
end
