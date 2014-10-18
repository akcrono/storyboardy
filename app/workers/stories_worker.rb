class StoriesWorker
  include Sidekiq::Worker

  def perform(story_id)
    story = Story.find(story_id)
    story.promote_best_submission!

    #unless stop
      # perform_in(5.hour, @story.id)
      StoriesWorker.perform_in(1.minutes, story.id)
    #end
  end

end
