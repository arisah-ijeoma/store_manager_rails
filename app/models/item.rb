class Item < ActiveRecord::Base
  has_many :users, through: :user_items
  has_many :user_items
end
