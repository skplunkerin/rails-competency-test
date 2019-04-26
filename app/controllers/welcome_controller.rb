class WelcomeController < ApplicationController
  def index
    # Get top 3 articles for each category
    @articles = {}
    Article.get_categories.each do |cat|
      @articles[cat.to_sym] = Article.where(category: cat).limit(3)
    end
  end
end
