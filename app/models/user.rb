class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password validations: false

  validates :username, :password, presence: true
  validates :username, length: {minimum: 6}, uniqueness: true
  validates :password, on: :create, length: {minimum: 8}
end