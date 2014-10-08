# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    body "MyText"
    association :user
    association :story
  end
end
