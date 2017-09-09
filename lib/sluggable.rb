module Sluggable
  extend ActiveSupport::Concern

  included do
    after_validation :generate_slug!
    class_attribute :slug_column
  end

  def to_slug
    slug = self.send(self.class.slug_column).gsub(/[^a-zA-Z0-9]/, '-').downcase
    slug.gsub(/[-]+/, '-')
  end

  def generate_slug!
    slug = to_slug
    a_regex = /\A#{slug}[\-0-9]*\z/
    count = self.class.select { |ele| ele.slug.match(a_regex)}.size

    self.slug = slug
    self.slug += '-' + count.to_s if count > 0
  end

  def to_param
    self.slug
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end