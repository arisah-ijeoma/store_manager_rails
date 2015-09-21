FactoryGirl.define do
  factory :item, class: Item do
    category  "Music"
    name      "Cassette"
    quantity  3
    min_qty 1
  end

  factory :invalid_item, class: Item do
    category  "Music"
    name      "Cassette"
    quantity  1
    min_qty  3

    trait :invalid_value do
      quantity '3e'
      min_qty 2
    end

    factory :invalid_item_value, traits: [:invalid_value]
  end
end

