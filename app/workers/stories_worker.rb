class StoriesWorker
  include Sidekiq::Worker

  def perform(story_id)
    story = Story.find(story_id)
    if !story.submissions.empty?
      story.promote_best_submission!

      StoriesWorker.perform_in(5.hours, story.id)
    end
  end

end
