class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable,
    polymorphic: true, counter_cache: true

  validates :user, presence: true
  validates :voteable_id, uniqueness: { scope: [:user_id, :voteable_type] }
  validates :voteable, presence: true
  validates :value, inclusion: { in: [1, -1] }
  validates :voteable_type, inclusion: { in: %w(Story Submission) }

  def upvote?
    value == 1
  end

  def downvote?
    value == -1
  end

  def change_vote!(user_vote)
    if user_vote == value
      voteable.increment!(:score, by = -user_vote) if voteable_type == "Story"
      delete
    else
      if value.nil?
        voteable.increment!(:score, by = user_vote) if voteable_type == "Story"
      else
        voteable.increment!(:score, by = user_vote * 2) if voteable_type == "Story"
      end
      self.value = user_vote
      save
    end
  end
end
