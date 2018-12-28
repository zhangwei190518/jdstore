FactoryBot.define do
  factory :comment do
    association :product, factory: :public_product
    association :user, factory: :random_user

    body { "确实是很强大的手机" }
  end
end
