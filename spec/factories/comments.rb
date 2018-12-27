FactoryBot.define do
  factory :comment do
    association :product, factory: :product
    association :user, factory: :user

    body { "确实是很强大的手机" }
  end
end