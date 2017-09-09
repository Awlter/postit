module Sluggable
  extend ActiveSupport::Concern

  included do
    after_validation :generate_slug!
  end

  def to_slug
    slug = self.sluggable_column.gsub(/[^a-zA-Z0-9]/, '-').downcase
    slug.gsub(/[-]+/, '-')
  end

  def generate_slug!
    slug = to_slug
    a_regex = /\A#{slug}[\-0-9]*\z/
    count = self.class.select { |ele| ele.slug.match(a_regex)}.size

    self.slug = slug
    self.slug += '-' + count.to_s if count > 0
  end

end