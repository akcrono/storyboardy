# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :addition do
    body "MyText"
    association :user
    association :story
    score 1
  end
end
