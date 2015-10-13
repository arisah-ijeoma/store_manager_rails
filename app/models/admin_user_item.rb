class AdminUserItem < ActiveRecord::Base
  belongs_to :admin_user
  belongs_to :item
end
