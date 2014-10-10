require 'csv'
require 'story_importer'
require 'submission_importer'

# user
StoryImporter.new('data/stories.csv').import
SubmissionImporter.new('data/submissions.csv').import
