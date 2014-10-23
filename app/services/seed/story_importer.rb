require_relative 'importer'

class StoryImporter < Importer
  def create(attributes)
    story = Story.new
    story.title = attributes[:title]
    story.user_id = User.all.sample.id
    story.first_entry = attributes[:first_entry]

    story.save
  end

  private

  def default_options
    { header_converters: :symbol, headers: true, col_sep: ',' }
  end
end
