class Article < ApplicationRecord
  belongs_to    :user

  # These fields are required
  validates                 :title, :category, :content, :slug,
                            presence: true
  validates_uniqueness_of   :title, :slug

  # Generate Slug
  before_validation   :fix_slug, :fix_category

  scope :get_categories, -> { all.pluck(:category).uniq }
  # Turns ['category_1', 'category_2'] to ['Category 1', 'Category 2']
  scope :get_category_titles, -> { all.pluck(:category).uniq.map{ |c| c.gsub(/[-_]/, ' ').titleize } }
  
  # Convert category_1 to 'Category 1'
  def category_friendly
    return self.category.gsub(/[-_]/, ' ').titleize
  end

  # Shorten content to use as article summary
  def content_summary(**args)
    length = args[:length] ? args[:length] : 50
    # If we can find first paragraph
    reg = Regexp.new(/(^<p>[^<]*<\/p>)/)
    if !self.content.match(reg).nil?
      return self.content.match(reg).captures[0].gsub(/<[a-z]{1,}[^>]*>|<\/[a-z]>/,'').truncate(length)
    end
    # Else, strip HTML and truncate
    return self.content.gsub(/<[a-z]{1,}[^>]*>|<\/[a-z]>/, '').truncate(length)
  end

  # Change default identifier param from :id, to :slug
  def to_param
    slug
  end

  private
  
  def fix_category
    if category.present?
      # 1. Downcase
      # 2. Convert non-alphanumeric characters to underscores
      # 3. Trim any start/end _'s
      self.category = Article.stripper(self.category, separator: '_')
    end
  end

  # Turn complicated titles like:
  #   -Test article 1 - tuna man 35 and j12-=$
  # To simple/user-friendly URL slugs like:
  #   test-article-1-tuna-man-35-and-j12
  def fix_slug
    # If title is present and slug not set
    if title.present? && !slug.present?
      fixed_slug = Article.stripper(self.title)
    end
    if slug.present?
      # Make sure slug matches format
      fixed_slug = Article.stripper(self.slug)
    end
    self.slug = fixed_slug
  end

  def self.stripper(s, **args)
    sep = args[:separator] ? args[:separator] : '-'
    # 1. Replace invalid characters (2+ consecutive characters) with a - (or separator)
    # 2. Replace invalid characters (individual characters) with a - (or separator)
    # 3. Trim any start/end -'s (from separator)
    return s.downcase.gsub(/[^A-Za-z0-9]{2,}/, sep).gsub(/[^A-Za-z0-9]/, sep).gsub(/^#{sep}|#{sep}$/, '')
  end

end
