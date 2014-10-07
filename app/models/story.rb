class Story < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :first_entry, presence: true
  validates :user, presence: true

end
