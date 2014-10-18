require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

describe StoriesWorker do
  it do
  story = FactoryGirl.create(:story)
  expect { StoriesWorker.perform_async(story.id) }.to change(StoriesWorker.jobs, :size).by(1)
  end
end

