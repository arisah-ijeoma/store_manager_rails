FactoryGirl.define do
  factory :user, class: User do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    association(:admin_user)
  end
end
