FactoryBot.define do
  factory :admin_user, class: 'AdminUser' do
    email { Faker::Internet.email }
    first_name { 'Jay' }
    last_name { 'Jay' }
    password { 'password' }
    role { 'regular' }
    establishment { Faker::Company.unique.name }

    trait :super do
      password { 'superpass' }
      role { 'super' }
    end

    factory :super_admin_user, traits: [:super]
  end
end
