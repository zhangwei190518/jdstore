FactoryBot.define do
  factory :product do
    association :category, factory: :category
    association :user, factory: :random_user

    trait :iPhone do
      title { "iPhone" }
      description { "新一代 iPhone" }
      price { 10499 }
    end

    trait :Mac do
      title { "Mac" }
      description { "新一代 Mac" }
      price { 14999 }
    end

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

    factory :public_product, traits: [:iPhone, :selling, :in_stock]
    factory :mac_product, traits: [:Mac, :selling, :in_stock]
    factory :hidden_product, traits: [:iPhone, :hidden, :in_stock]
    factory :sell_out_product, traits: [:iPhone, :selling, :sell_out]
  end
end
