class Transaction < ActiveRecord::Base
  belongs_to :admin_user
  belongs_to :user
  belongs_to :item

  scope :daily, -> {
    where(updated_at: (Time.zone.now.beginning_of_day..Time.zone.now.end_of_day))
  }
end
