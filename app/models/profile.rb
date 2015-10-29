class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin_user

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :admin_user

  delegate :first_name, :last_name, :establishment, :role, to: :admin_user
end
