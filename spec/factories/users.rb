FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "#{username}@gmail.com" }
    sequence(:mobile) {|n| "151#{email.hash.abs.to_s[0..7]}" }
    password '12345678'
    password_confirmation '12345678'
  end
end