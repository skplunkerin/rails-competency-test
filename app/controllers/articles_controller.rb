class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_page

  def index
    @articles = Article.all.limit(12)
  end

  def show
    @article = Article.find_by_slug(params[:slug])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  def set_page
    @articlespage = 'active'
  end
end
