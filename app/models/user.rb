class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :admin_user

  validates :first_name, presence: true
  validates :last_name, presence: true

  delegate :establishment, to: :admin_user

  def full_name
    self.first_name + " " + self.last_name
  end
end
