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

  def self.hot
    order(created_at: :desc)
  end

  def self.controvertial
    Story.select("stories.id, stories.title, stories.first_entry, stories.created_at, stories.user_id, count(votes.id) as votes_count").
      joins(:votes).group("stories.id").order("votes_count DESC")
  end

  def self.populate_index_with(query)
    if query[:search]
      Story.search(query[:search]).order(created_at: :desc)
    elsif query[:newest]
      @astories = Story.order(created_at: :desc)
    elsif query[:top]
      @stories = Story.top
    elsif query[:controvertial]
      @stories = Story.controvertial
    else
      Story.hot
    end
  end

  def timestamp
    created_at.strftime('%B %d %Y %H:%M:%S')
  end
end
