require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

describe Story do
  it { should respond_to(:user) }
  it { should respond_to(:submissions) }

  it "has a valid factory" do
    FactoryGirl.create(:story).should be_valid
  end

  it "is invalid without a user" do
    FactoryGirl.build(:story, user: nil).should_not be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:story, title: nil).should_not be_valid
  end

  it "is invalid without a body" do
    FactoryGirl.build(:story, first_entry: nil).should_not be_valid
  end

  it "should return most controversial" do
    story1 = FactoryGirl.create(:story)
    story2 = FactoryGirl.create(:story)
    Vote.new(user_id: story1.user.id,
      voteable_id: story1.id,
      voteable_type: "Story").change_vote!(1)
    Vote.new(user_id: story2.user.id,
      voteable_id: story1.id,
      voteable_type: "Story").change_vote!(-1)
    Vote.new(user_id: story1.user.id,
      voteable_id: story2.id,
      voteable_type: "Story").change_vote!(1)

    expect(Story.populate_index_with(controversial: true).first).to eq(story1)
  end

  it "should return highest score" do
    story1 = FactoryGirl.create(:story)
    story2 = FactoryGirl.create(:story)
    Vote.new(user_id: story1.user.id,
      voteable_id: story1.id,
      voteable_type: "Story").change_vote!(1)
    Vote.new(user_id: story2.user.id,
      voteable_id: story1.id,
      voteable_type: "Story").change_vote!(-1)
    Vote.new(user_id: story1.user.id,
      voteable_id: story2.id,
      voteable_type: "Story").change_vote!(1)

    expect(Story.populate_index_with(top: true).first).to eq(story2)
  end

  it "should return newest" do
    story1 = FactoryGirl.create(:story)
    story2 = FactoryGirl.create(:story)

    expect(Story.populate_index_with(newest: true).first).to eq(story2)
  end

  it "returns the best submission" do
    story = FactoryGirl.create(:story)
    submission1 = FactoryGirl.create(:submission, story: story)
    submission2 = FactoryGirl.create(:submission, story: story)
    Vote.new(user_id: submission1.user.id,
      voteable_id: submission1.id,
      voteable_type: "Submission").change_vote!(1)
    Vote.new(user_id: submission2.user.id,
      voteable_id: submission1.id,
      voteable_type: "Submission").change_vote!(-1)
    Vote.new(user_id: submission1.user.id,
      voteable_id: submission2.id,
      voteable_type: "Submission").change_vote!(1)

    expect(story.best_submission).to eq(submission2)
  end

  it "chooses the best story as an addition, and delete other submissions for that story" do
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
    story.promote_best_submission!

    expect(story.submissions).to be_empty
    expect(story.additions.first.body).to include 'winner'
    expect(story.additions.first.body).to_not include 'loser'
    expect(other_story.submissions).to include submission3
  end

  it "chooses the best story as an addition, and delete other submissions for that story" do
    story = FactoryGirl.create(:story)
    other_story = FactoryGirl.create(:story)
    submission1 = FactoryGirl.create(:submission, story: story, body: 'not seen')
    submission2 = FactoryGirl.create(:submission, story: story, body: 'seen, 1 view')
    submission3 = FactoryGirl.create(:submission, story: story, body: 'seen, most views')
    View.create(user_id: submission1.user.id,
      submission_id: submission1.id)
    View.create(user_id: submission1.user.id,
      submission_id: submission2.id)
    View.create(user_id: submission1.user.id,
      submission_id: submission3.id)
    View.create(user_id: submission2.user.id,
      submission_id: submission3.id)

    submissions = story.submissions_to_be_viewed(submission3.user_id)
    expect(submissions.first).to eq(submission1)
    expect(submissions.second).to eq(submission2)
    expect(submissions.third).to eq(submission3)

  end
end
