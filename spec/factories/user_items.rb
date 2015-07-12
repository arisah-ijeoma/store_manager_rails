FactoryGirl.define do
  factory :user_item, class: UserItem do
    user
    item
  end
end
