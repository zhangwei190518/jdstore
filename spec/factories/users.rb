FactoryBot.define do
  factory :user do
    email { "test@gmail.com" }
    mobile { "15100000000" }
    password { Faker::Internet.password }
    password_confirmation { password }
  end

  factory :random_user, class: User do
    email { Faker::Internet.safe_email }
    mobile { Faker::PhoneNumber.cell_phone }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end
