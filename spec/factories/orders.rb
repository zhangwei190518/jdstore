FactoryBot.define do
  factory :order do
    association :user, factory: :random_user

    total { Faker::Number.between(1, 10000) }
    shipping_name { Faker::Name.name }
    shipping_address { Faker::Address.full_address }

    trait :paid do
      is_paid { true }
    end

    trait :unpaid do
      is_paid { false }
    end

    factory :public_order, traits: [:paid]
  end
end