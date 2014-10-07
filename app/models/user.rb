class User < ActiveRecord::Base
  has_many :stories
  validates :username,
    uniqueness: { case_sensitive: false },
    presence: true
    validates :email,
    uniqueness: { case_sensitive: false },
    presence: true

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
end
