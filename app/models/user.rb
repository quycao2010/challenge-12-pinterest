class User < ActiveRecord::Base
  before_save { email.downcase! }
  acts_as_voter
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  has_many :pins
end
