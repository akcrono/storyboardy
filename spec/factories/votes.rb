# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    association :user
    association :voteable, factory: :story
    value 1
    voteable_type "Story"

    trait :vote_submission do
    association :voteable, factory: :submission
    voteable_type "Submission"
    end

    factory :vote_submission, traits: [:vote_submission]
  end
end
