FactoryGirl.define do
  factory :item, class: Item do
    category  "Music"
    name      "Cassette"
    quantity  3
    min_qty 1

    trait :name_case do
      name    "my item name"
      brand   "DMX"
    end

    trait :empty_brand do
      brand   " "
    end

    factory :valid_item_name_case, traits: [:name_case]
    factory :valid_item_empty_brand, traits: [:empty_brand]
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

