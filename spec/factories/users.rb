FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "#{n}@gmail.com" }
    mobile { "15100000000" }
    password { "12345678" }
    password_confirmation { "12345678" }
  end
end