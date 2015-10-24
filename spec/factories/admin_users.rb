FactoryGirl.define do
  factory :admin_user do
    email { Faker::Internet.email }
    first_name 'Jay'
    last_name 'Jay'
    password 'password'
    role 'regular'
    establishment 'Cookie Bar'
  end

  factory :super_admin_user, class: 'AdminUser' do
    email { Faker::Internet.email }
    first_name 'Jay'
    last_name 'Jay'
    password 'superpass'
    role 'super'
    establishment 'Karaoke Bar'
  end
end
