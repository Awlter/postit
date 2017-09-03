class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password validation: false

  validates :username, :password, :password_confirmation, presence: true
  validates :username, length: {minimum: 6}, uniqueness: true
  validates :password, length: {minimum: 8}
end