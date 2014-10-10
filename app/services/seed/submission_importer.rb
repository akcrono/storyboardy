require_relative 'importer'

class SubmissionImporter < Importer
  def create(attributes)
    submission = Submission.find_or_initialize_by(id: attributes[:id])
    submission.story_id = attributes[:story_id]
    submission.user_id = attributes[:user_id]
    submission.body = attributes[:body]

    submission.save
  end

  private

  def default_options
    { header_converters: :symbol, headers: true, col_sep: ',' }
  end
end
