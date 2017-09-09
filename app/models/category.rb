class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true

  after_validation :generate_slug

  def to_slug
    slug = self.name.gsub(/[^a-zA-Z0-9]/, '-').downcase
    self.slug = slug.gsub(/[-]+/, '-')
  end

  def generate_slug
    to_slug
    a_regex = /\A#{to_slug}[\-0-9]*\z/
    count = Category.select { |cate| cate.slug.match(a_regex)}.size

    self.slug += '-' + count.to_s if count > 0
  end

  def to_param
    self.slug
  end
end