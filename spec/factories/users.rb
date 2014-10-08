# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "frank#{n}@tank.com" }
    sequence(:username) { |n| "frank#{n}" }
    password 'abcd1234'

    trait :admin do
      role 'admin'
    end

    trait :invalid_user do
      username ''
    end

    factory :admin, traits: [:admin]
    factory :invalid_user, traits: [:invalid_user]
  end
end
