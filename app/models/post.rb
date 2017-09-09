class Post < ActiveRecord::Base
  include Voteable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, :url, :description, presence: true
  validates :title, length: {minimum: 5}
  validates :url, uniqueness: true

  after_validation :generate_slug

  def sorted_comments
    self.comments.sort_by {|x| x.total_votes}.reverse
  end

  def to_slug
    slug = self.title.gsub(/[^a-zA-Z0-9]/, '-').downcase
    self.slug = slug.gsub(/[-]+/, '-')
  end

  def generate_slug
    to_slug
    a_regex = /\A#{to_slug}\[\-0-9]*\z/
    count = Post.select { |post| post.slug.match(a_regex)}.size

    self.slug += '-' + count.to_s if count > 0
  end


  def to_param
    self.slug
  end
end
