class SubmissionsWorker
  include Sidekiq::Worker

  def perform(submissions_id_array, user_id)
    submissions_id_array.each do |submission_id|
      view = View.find_or_initialize_by(submission_id: submission_id, user_id: user_id)
      view.save
    end
  end

end
