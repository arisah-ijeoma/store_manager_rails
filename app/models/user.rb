class User < ActiveRecord::Base
  after_create :build_profile

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :admin_user
  has_one :profile, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :admin_user_id, presence: true

  delegate :establishment, to: :admin_user
  delegate :phone_number, to: :profile

  def full_name
    self.first_name + " " + self.last_name
  end

  private

  def build_profile
    Profile.create(user: self)
  end
end
