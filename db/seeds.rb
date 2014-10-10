require 'csv'
require 'story_importer'
require 'submission_importer'

UserImporter.new('data/users.csv').import
StoryImporter.new('data/stories.csv').import
SubmissionImporter.new('data/submissions.csv').import
