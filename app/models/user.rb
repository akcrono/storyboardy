class User < ActiveRecord::Base
  has_many :stories
  has_many :additions
  has_many :submissions
  validates :username,
    uniqueness: { case_sensitive: false },
    presence: true
    validates :email,
    uniqueness: { case_sensitive: false },
    presence: true
  validates :encrypted_password, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:login]

  attr_accessor :login

  def admin?
    role == 'admin'
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def voted_on?(voteable, voteable_type="Story")
    vote = Vote.find_by(user_id: id, voteable_id: voteable.id, voteable_type: voteable_type)
    vote ? vote.value : false
    #FIX RETURN TYPE.  HOW DO WE WANT TO MANAGE THIS
  end
end
