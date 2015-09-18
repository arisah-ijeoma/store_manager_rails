FactoryGirl.define do
  factory :admin_user do
    email { Faker::Internet.email }
    password 'password'
    role 'regular'
  end

  factory :super_admin_user, class: 'AdminUser' do
    email { Faker::Internet.email }
    password 'superpass'
    role 'super'
  end
end
