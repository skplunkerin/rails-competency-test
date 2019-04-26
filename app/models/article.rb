class Article < ApplicationRecord
  belongs_to    :user

  # These fields are required
  validates                 :title, :category, :content,
                            presence: true
  validates_uniqueness_of   :title, :slug

  before_create   :create_slug

  private
  # Turn complicated titles like:
  #   -Test article 1 - tuna man 35 and j12-=$
  # To simple/user-friendly URL slugs like:
  #   test-article-1-tuna-man-35-and-j12
  def create_slug
    # If title is present and slug not set
    if title.present? && !slug.present?
      # 1. Replace invalid characters (2+ consecutive characters) with a -
      # 2. Replace invalid characters (individual characters) with a -
      # 3. Trim any start/end -'s
      self.slug = self.title.downcase.gsub(/[^A-Za-z0-9]{2,}/, '-').gsub(/[^A-Za-z0-9]/, '-').gsub(/^-|-$/, '')
    end
  end

end
