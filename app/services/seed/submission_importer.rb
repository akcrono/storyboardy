require_relative 'importer'

class SubmissionImporter < Importer
  def create(attributes)
    submission = Submission.new
    submission.story_id = Story.all.sample
    submission.user_id = User.all.sample
    submission.body = attributes[:body]

    submission.save
  end

  private

  def default_options
    { header_converters: :symbol, headers: true, col_sep: ',' }
  end
end
