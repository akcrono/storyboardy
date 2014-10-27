require 'rails_helper'

describe View do
  it { should respond_to(:user) }
  it { should respond_to(:submission) }

  it "has a valid factory" do
    FactoryGirl.create(:view).should be_valid
  end

  it "is invalid without a user" do
    FactoryGirl.build(:view, user: nil).should_not be_valid
  end

  it "is invalid without a submission" do
    FactoryGirl.build(:view, submission: nil).should_not be_valid
  end

  it "is unique" do
    view = FactoryGirl.create(:view)
    invalid_view = FactoryGirl.build(:view, submission: view.submission, user: view.user)
    expect(invalid_view.valid?).to eq(false)
  end

  it "is destroyed when submission is destroyed" do
    submission = FactoryGirl.create(:submission)
    view = FactoryGirl.create(:view, submission: submission)
    id = view.id
    Submission.destroy_all

    expect(View.where(id: id).empty?).to eq(true)
  end

end
