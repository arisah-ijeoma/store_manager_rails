class Item < ActiveRecord::Base
  has_many :admin_users, through: :admin_user_items
  has_many :admin_user_items

  validates_numericality_of :quantity,
                            greater_than_or_equal_to: 0,
                            only_integer: true
end
