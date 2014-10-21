require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

describe StoriesWorker do

  it "picks the best submissions" do
    story = FactoryGirl.create(:story)
    other_story = FactoryGirl.create(:story)
    loser_submission = FactoryGirl.create(:submission, story: story, body: 'loser')
    winning_submission = FactoryGirl.create(:submission, story: story, body: 'winner')
    submission3 = FactoryGirl.create(:submission, story: other_story)
    Vote.new(user_id: loser_submission.user.id,
      voteable_id: loser_submission.id,
      voteable_type: "Submission").change_vote!(1)
    Vote.new(user_id: winning_submission.user.id,
      voteable_id: loser_submission.id,
      voteable_type: "Submission").change_vote!(-1)
    Vote.new(user_id: loser_submission.user.id,
      voteable_id: winning_submission.id,
      voteable_type: "Submission").change_vote!(1)
    StoriesWorker.perform_async(story.id)

    expect(story.submissions).to be_empty
    expect(story.additions.first.body).to include 'winner'
    expect(story.additions.first.body).to_not include 'loser'
    expect(other_story.submissions).to include submission3
  end
end

