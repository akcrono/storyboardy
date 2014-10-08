class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  paginates_per 10

  validates :body, presence: true
  validates :user, presence: true
  validates :story, presence: true

end
