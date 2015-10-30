class AdminUser < ActiveRecord::Base
  after_create :build_admin_profile

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :users, dependent: :destroy
  has_many :items, through: :admin_user_items
  has_many :admin_user_items
  has_one :profile, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :establishment, presence: true, uniqueness: { case_sensitive: false, message: "This establishment already exists" }

  ROLES = %w(super regular) unless defined? ROLES

  scope :regular_admins, -> { where(role: 'regular') }

  delegate :salutation, :mobile_number, :phone_number, to: :profile

  def admin_full_name
    if self.salutation.present?
      self.salutation + "  " + self.first_name + " " + self.last_name
    else
      self.first_name + " " + self.last_name
    end
  end

  private

  def build_admin_profile
    Profile.create(admin_user: self)
  end
end
