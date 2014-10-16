require 'rails_helper'

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
end
