class Item < ActiveRecord::Base
  has_many :admin_users, through: :admin_user_items
  has_many :admin_user_items

  validate :min_qty_is_less_than_quantity
  validates_numericality_of :quantity, greater_than_or_equal_to: 0, only_integer: true
  validates_numericality_of :min_qty, greater_than_or_equal_to: 0, only_integer: true

  private

  def valid_values?
    quantity == nil || min_qty == nil
  end

  def min_qty_is_less_than_quantity
    unless valid_values?
      errors.add(:min_qty, "should be less than quantity added") if min_qty > quantity
    else
      return
    end
  end
end
