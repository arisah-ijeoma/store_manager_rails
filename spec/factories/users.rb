FactoryBot.define do
  factory :user, class: User do
    email { Faker::Internet.email }
    first_name { 'Jay' }
    last_name { 'Jay' }
    password { 'password' }
    password_confirmation { 'password' }
    association(:admin_user)
  end
end
