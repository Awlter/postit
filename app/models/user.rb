class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true
  validates :username, length: {minimum: 6}, uniqueness: true
  validates :password,  presence: true, on: :create, length: {minimum: 8}

  after_validation :generate_slug

  def sorted_posts
    self.posts.sort_by {|x| x.total_votes }.reverse
  end

  def sorted_comments
    self.comments.sort_by {|x| x.total_votes }.reverse
  end

  def generate_slug
    self.slug = self.username.gsub(' ', '-').downcase
  end

  def to_param
    self.slug
  end
end