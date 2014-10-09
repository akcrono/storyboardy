class Story < ActiveRecord::Base
  belongs_to :user
  has_many :submissions, dependent: :destroy
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :first_entry, presence: true
  validates :user, presence: true

  def vote_score
    votes.sum(:value)
  end
end
