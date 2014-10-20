require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

describe SubmissionsWorker do

  it "creates views for story" do
    story = FactoryGirl.create(:story)
    submission1 = FactoryGirl.create(:submission, story: story)
    submission2 = FactoryGirl.create(:submission, story: story)
    subs = story.submissions

    SubmissionsWorker.perform_async([submission1.id, submission2.id], story.user.id)
    expect(story.user.views).to include (View.find_by(user_id: story.user.id, submission_id: submission1.id))
    expect(story.user.views).to include (View.find_by(user_id: story.user.id, submission_id: submission2.id))
  end
end

