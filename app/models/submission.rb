class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  has_many :votes, as: :voteable
  has_many :views, dependent: :destroy


  validates :body, presence: true
  validates :user, presence: true
  validates :story, presence: true


  def vote_score
    votes.sum(:value)
  end
end
