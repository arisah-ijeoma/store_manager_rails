FactoryGirl.define do
  factory :transaction, class: 'Transaction' do
    association(:admin_user)
    association(:user)
    association(:item)
  end
end
