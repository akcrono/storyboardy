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

end
