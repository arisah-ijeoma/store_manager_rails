class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:google_oauth2, :facebook]

  belongs_to :admin_user

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    self.first_name + " " + self.last_name
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data.email).first

    unless user
      user = User.create(name: data.name,
         email: data.email,
         password: Devise.friendly_token[0,20]
      )
    end

    user
  end
end
