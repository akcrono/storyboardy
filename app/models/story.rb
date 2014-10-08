class Story < ActiveRecord::Base
  belongs_to :user
  has_many :submissions, dependent: :destroy

  validates :title, presence: true
  validates :first_entry, presence: true
  validates :user, presence: true

end
