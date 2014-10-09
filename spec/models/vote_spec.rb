require 'rails_helper'

describe Vote do
  it { should respond_to(:user) }
  it { should respond_to(:voteable) }

  it "has a valid factory" do
    FactoryGirl.create(:vote).should be_valid
  end

  it "is invalid without a user" do
    FactoryGirl.build(:vote, user: nil).should_not be_valid
  end

  it "is invalid without a voteable_type" do
    FactoryGirl.build(:vote, voteable_type: nil).should_not be_valid
  end

  it "is invalid without a value" do
    FactoryGirl.build(:vote, value: nil).should_not be_valid
  end

  it "is invalid without a voteable" do
    FactoryGirl.build(:vote, voteable: nil).should_not be_valid
  end

  it "returns true if upvote" do
    FactoryGirl.build(:vote, value: 1).upvote?.should eq(true)
  end

  it "returns false if not upvote" do
    FactoryGirl.build(:vote, value: -1).upvote?.should eq(false)
  end

  it "returns true if downvote" do
    FactoryGirl.build(:vote, value: -1).downvote?.should eq(true)
  end

  it "returns false if not downvote" do
    FactoryGirl.build(:vote, value: 1).downvote?.should eq(false)
  end

  it "returns vote value if voted on" do
    vote = FactoryGirl.create(:vote)
    vote.user.voted_on?(vote.voteable).should eq(1)
  end

  it "returns nil value if not voted on" do
    user = FactoryGirl.create(:user)
    story = FactoryGirl.create(:story)
    user.voted_on?(story).should eq(false)
  end
end
