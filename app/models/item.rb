class Item < ActiveRecord::Base
  has_many :admin_users, through: :admin_user_items
  has_many :admin_user_items

  validate :min_qty_is_less_than_quantity
  validates :category, presence: true
  validates_uniqueness_of :name, {:case_sensitive => false, message: "This item already exists"}
  validates_numericality_of :quantity, greater_than_or_equal_to: 0, only_integer: true
  validates_numericality_of :quantity_sold, greater_than_or_equal_to: 0, only_integer: true
  validates_numericality_of :min_qty, greater_than_or_equal_to: 0, only_integer: true

  ITEM_LIST = [
      "Books",
      "Fashion",
      "Mobile Phones",
      "Computing",
      "Electronics",
      "Games",
      "Home",
      "Health & Beauty",
      "Movies",
      "Music",
      "Office",
      "Watches",
      "Sunglasses",
      "Toys for Kids",
      "Other Categories"
  ]

  private

  def min_qty_is_less_than_quantity
    unless valid_values?
      errors.add(:min_qty, "should be less than quantity added") if min_qty > quantity
    end
  end

  def valid_values?
    quantity == nil || min_qty == nil
  end
end
