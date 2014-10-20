class View < ActiveRecord::Base
  belongs_to :user
  belongs_to :submission

  validates :user, presence: true
  validates :submission, presence: true
  validates_uniqueness_of :user, scope: :submission
end
