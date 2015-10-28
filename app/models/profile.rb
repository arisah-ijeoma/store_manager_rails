class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin_user

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :admin_user

  delegate :first_name, to: :admin_user
  delegate :last_name, to: :admin_user
  delegate :establishment, to: :admin_user
  delegate :role, to: :admin_user
end
