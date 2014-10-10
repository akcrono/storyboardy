require_relative 'importer'

class StoryImporter < Importer
  def create(attributes)
    story = Story.find_or_initialize_by(id: attributes[:id])
    story.title = attributes[:title]
    story.user_id = attributes[:user_id]
    story.first_entry = attributes[:first_entry]

    story.save
  end

  private

  def default_options
    { header_converters: :symbol, headers: true, col_sep: ',' }
  end
end
