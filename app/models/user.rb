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

  def to_slug
    slug = self.username.gsub(/[^a-zA-Z0-9]/, '-').downcase
    self.slug = slug.gsub(/[-]+/, '-')
  end

  def generate_slug
    to_slug
    a_regex = /\A#{to_slug}[\-0-9]*\z/
    count = User.select { |user| user.slug.match(a_regex)}.size

    self.slug += '-' + count.to_s if count > 0
  end


  def to_param
    self.slug
  end
end