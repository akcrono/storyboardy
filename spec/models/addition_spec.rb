require 'rails_helper'

describe Addition do
  it { should respond_to(:user) }
  it { should respond_to(:story) }

  it "has a valid factory" do
    FactoryGirl.create(:addition).should be_valid
  end

  it "is invalid without a user" do
    FactoryGirl.build(:addition, user: nil).should_not be_valid
  end

  it "is invalid without a story" do
    FactoryGirl.build(:addition, story: nil).should_not be_valid
  end

  it "is invalid without a body" do
    FactoryGirl.build(:addition, body: nil).should_not be_valid
  end

end
