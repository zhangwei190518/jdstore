FactoryBot.define do
  factory :product do
    association :category, factory: :category
    association :user, factory: :user

    title { "iPhone" }
    description { "新一代 iPhone" }
    quantity { 20 }
    price { 10499 }
    is_hidden { false }
  end
end
