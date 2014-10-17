class StoriesWorker
  include Sidekiq::Worker

  def perform(story_id)
    @story = Story.find(story_id)
    # Submission.create(story_id: story_id, user_id: user, body: "Test at #{Time.now}")
    best = @story.best_submission
    Addition.create(user_id: best.user_id, story_id: best.story_id, body: best.body, score: best.vote_score)
    @story.submissions.destroy_all

    #unless stop
      # perform_in(5.hour, @story.id)
      StoriesWorker.perform_in(5.hours, story_id)
    #end
  end

end
