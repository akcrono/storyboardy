require 'csv'
require 'story_importer'
require 'submission_importer'
require 'betterlorem'

UserImporter.new('data/users.csv').import
puts "Users loaded"
StoryImporter.new('data/stories.csv').import
puts "Stories loaded"
SubmissionImporter.new('data/submissions.csv').import
puts "Submissions loaded"
# puts BetterLorem.p
stories = Story.all.each do |story|

  Addition.create(user_id: [1,2,3,4].sample, story_id: story.id, score: [50,100,200,500].sample,
    body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ut reiciendis labore ratione sunt vero ea sed maiores quibusdam veritatis molestias, ex ipsum, consequatur culpa minima odit, eligendi tenetur, minus harum!  Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ut reiciendis labore ratione sunt vero ea sed maiores quibusdam veritatis molestias, ex ipsum, consequatur culpa minima odit, eligendi tenetur, minus harum!  Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ut reiciendis labore ratione sunt vero ea sed maiores quibusdam veritatis molestias, ex ipsum, consequatur culpa minima odit, eligendi tenetur, minus harum!  Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ut reiciendis labore ratione sunt vero ea sed maiores quibusdam veritatis molestias, ex ipsum, consequatur culpa minima odit, eligendi tenetur, minus harum!  Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ut reiciendis labore ratione sunt vero ea sed maiores quibusdam veritatis molestias, ex ipsum, consequatur culpa minima odit, eligendi tenetur, minus harum!  Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ut reiciendis labore ratione sunt vero ea sed maiores quibusdam veritatis molestias, ex ipsum, consequatur culpa minima odit, eligendi tenetur, minus harum!
")
end
