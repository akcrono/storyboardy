require 'csv'
require 'story_importer'
require 'submission_importer'

UserImporter.new('data/users.csv').import
puts "Users loaded"
StoryImporter.new('data/stories.csv').import
puts "Stories loaded"
SubmissionImporter.new('data/submissions.csv').import
puts "Submissions loaded"
