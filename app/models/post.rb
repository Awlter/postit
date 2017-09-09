class Post < ActiveRecord::Base
  include Voteable
  include Sluggable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, :url, :description, presence: true
  validates :title, length: {minimum: 5}
  validates :url, uniqueness: true

  def sorted_comments
    self.comments.sort_by {|x| x.total_votes}.reverse
  end

  def sluggable_column
    self.title
  end
end
