# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :view do
    association :user
    association :submission
  end
end
