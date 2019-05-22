class SalutationToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :salutation, :string
  end
end
