require 'rails_helper'

describe Submission do
  it { should respond_to(:user) }
  it { should respond_to(:story) }

  it "has a valid factory" do
    FactoryGirl.create(:submission).should be_valid
  end

  it "is invalid without a user" do
    FactoryGirl.build(:submission, user: nil).should_not be_valid
  end

  it "is invalid without a story" do
    FactoryGirl.build(:submission, story: nil).should_not be_valid
  end

  it "is invalid without a body" do
    FactoryGirl.build(:submission, body: nil).should_not be_valid
  end

end
