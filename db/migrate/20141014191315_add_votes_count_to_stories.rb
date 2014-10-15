class AddVotesCountToStories < ActiveRecord::Migration
  def up
    add_column :stories, :votes_count, :integer, default: 0, null: false
    add_column :stories, :score, :integer, default: 0, null: false

    add_column :submissions, :votes_count, :integer, default: 0, null: false

    Story.select(:id) do |result|
      Story.reset_counters(result.id, :votes)
    end

    Story.select(:id) do |story|
      story.update(score: (story.votes.sum(:value)))
    end

    Submission.select(:id) do |result|
      Submission.reset_counters(result.id, :votes)
    end

  end

  def down
    remove_column :stories, :votes_count
    remove_column :stories, :score

    remove_column :submissions, :votes_count
  end
end
