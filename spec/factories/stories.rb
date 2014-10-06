FactoryGirl.define do
  factory :story do
    association :user
    title 'Taco time'
    first_entry 'It was the time of the taco.'
  end
end
