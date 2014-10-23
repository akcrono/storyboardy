require 'csv'
require 'story_importer'
require 'submission_importer'
require 'betterlorem'

UserImporter.new('data/users.csv').import
puts "Users loaded"
StoryImporter.new('data/stories.csv').import
puts "Stories loaded"

Story.all.each do |story|
  5.times do
    Submission.create(
    story_id: story.id,
    user_id: User.all.sample.id,
    body: BetterLorem.w(50, true))
  end
end
puts "Submissions loaded"
Story.all.each do |story|
  3.times do
    Addition.create(user_id: User.all.sample,
      story_id: story.id,
      user_id: User.all.sample.id,
      score: [50,100,200,500].sample,
      body: BetterLorem.w(50, true))
  end
end
puts "Additions loaded"
