FactoryGirl.define do
  factory :product do
    association :category, factory: :category

    sequence(:title) {|n| "iPhone#{n}#{RandomGenerator.random algorithm: :code}号" }
    description '新一代 iPhone'
    quantity 20
    price 10499
    is_hidden false
  end
end
