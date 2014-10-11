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

  def self.search(search)
    where('title ILIKE ?', "%#{search}%")
  end

  def self.populate_index_with(query)
    if query[:search]
      Story.search(query[:search]).order(created_at: :desc)
    # elsif query[:newest]
    #   @astories = Story.order(created_at: :desc)
    else
      Story.order(created_at: :desc)
    end
  end
end
