FactoryGirl.define do
  factory :admin_user do
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    role 'regular'
  end

  factory :super_admin_user, class: 'AdminUser' do
    email { Faker::Internet.email }
    password 'superpass'
    password_confirmation 'superpass'
    role 'super'
  end
end
