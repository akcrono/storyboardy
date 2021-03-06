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

  def best_submission
    submissions.joins(:votes).group('submissions.id').order('SUM(votes.value)').last
  end

  def promote_best_submission!
    best = best_submission
    Addition.create(user_id: best.user_id, story_id: best.story_id, body: best.body, score: best.vote_score)
    submissions.destroy_all
  end

  def submissions_to_be_viewed(user_id)
    submissions.find_by_sql("select submissions.*, users.username,
              count(views.submission_id) as views_count,
              (select count(*) from views
                where views.user_id=#{user_id} and views.submission_id=submissions.id group by id) as counted,
              (select sum(value) as score from votes
                where voteable_type='Submission' and voteable_id=submissions.id) as score
              from submissions
              left outer join views on views.submission_id=submissions.id
              join users on submissions.user_id=users.id
              where submissions.story_id = #{id}
              group by submissions.id, users.username
              order by counted desc, views_count")
    # shown_submissions = submissions.find_by_sql("select submissions.*, count(views.submission_id) as views_count from submissions
    #                         left outer join views on views.submission_id=submissions.id
    #                         where submissions.story_id = #{id}
    #                         group by submissions.id
    #                         order by count(views.user_id=#{user_id}), views_count")

    # Needs refactor to avoid SQL injections
  end

  def timestamp
    created_at.strftime('%B %d %Y %H:%M:%S')
  end
end
