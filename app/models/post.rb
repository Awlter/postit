class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, :url, :description, presence: true
  validates :title, length: {minimum: 5}
  validates :url, uniqueness: true

  after_validation :generate_slug

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

  def sorted_comments
    self.comments.sort_by {|x| x.total_votes}.reverse
  end

  def to_slug
    slug = self.title.gsub(/[^a-zA-Z0-9]/, '-').downcase
    self.slug = slug.gsub(/[-]+/, '-')
  end

  def generate_slug
    to_slug
    count = Post.select { |post| post.slug.start_with?(to_slug)}.size

    self.slug += '-' + count.to_s if count > 0
  end

  def to_param
    self.slug
  end
end
