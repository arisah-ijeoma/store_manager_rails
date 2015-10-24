class AdminUser < ActiveRecord::Base

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :users, dependent: :destroy
  has_many :items, through: :admin_user_items
  has_many :admin_user_items

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :establishment, presence: true

  ROLES = %w(super regular) unless defined? ROLES

  scope :regular_admins, -> { where(role: 'regular') }



  def admin_full_name
    self.first_name + " " + self.last_name
  end
end
