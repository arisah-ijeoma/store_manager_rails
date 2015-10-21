FactoryGirl.define do
  factory :admin_user do
    email { Faker::Internet.email }
    password 'password'
    role 'regular'
    establishment 'Cookie Bar'
  end

  factory :super_admin_user, class: 'AdminUser' do
    email { Faker::Internet.email }
    password 'superpass'
    role 'super'
    establishment 'Karaoke Bar'
  end
end
