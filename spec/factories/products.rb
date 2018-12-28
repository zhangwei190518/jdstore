FactoryBot.define do
  factory :product do
    association :category, factory: :category
    association :user, factory: :random_user

    title { "iPhone" }
    description { "新一代 iPhone" }
    price { 10499 }

    trait :hidden do
      is_hidden { true }
    end

    trait :selling do
      is_hidden { false }
    end

    trait :sell_out do
      quantity { 0 }
    end

    trait :in_stock do
      quantity { 20 }
    end

    factory :selling_product, traits: [:selling, :in_stock]
    factory :hidden_product, traits: [:hidden, :in_stock]
    factory :sell_out_product, traits: [:selling, :sell_out]
  end
end
