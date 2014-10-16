class Story < ActiveRecord::Base
  belongs_to :user
  has_many :submissions, dependent: :destroy
  has_many :additions, dependent: :destroy
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :first_entry, presence: true
  validates :user, presence: true

  def self.search(search)
    where('title ILIKE ?', "%#{search}%")
  end

  def self.hot
    order(created_at: :desc)
  end

  def self.top
    Story.order(score: :desc, votes_count: :desc)
  end

  def self.controversial
    Story.order(votes_count: :desc, score: :desc)
  end

  def self.populate_index_with(query)
    if query[:search]
      Story.search(query[:search]).order(created_at: :desc)
    elsif query[:newest]
      Story.order(created_at: :desc)
    elsif query[:top]
      Story.top
    elsif query[:controversial]
      Story.controversial
    else
      Story.hot
    end
  end

  def timestamp
    created_at.strftime('%B %d %Y %H:%M:%S')
  end
end
