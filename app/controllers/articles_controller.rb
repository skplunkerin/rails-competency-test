class ArticlesController < ApplicationController
  # Petergate access
  access  all: [:index], user: [:show], editor: :all, admin: :all

  before_action :authenticate_user!, except: [:index]
  before_action :set_page, only: [:index, :show]

  def index
    @articles = Article.all.limit(12)
  end

  def show
    @article = Article.find_by_slug(params[:slug])
    has_access(skip_redirect: true) # need to call after @article defined
  end

  def new
    @newarticlepage = 'active'
    @article = Article.new
  end

  def create
    puts '=== params ==='
    puts params
    puts '=== article_params ==='
    puts article_params
    @newarticlepage = 'active'
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      flash[:info] = 'Article created!'
      redirect_to article_path(@article.slug)
    else
      flash[:alert] = @article.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def edit
    @article = Article.find_by_slug(params[:slug])
    has_access # need to call after @article defined
  end

  def update
    @article = Article.find_by_slug(params[:slug])
    if has_access # need to call after @article defined
      if @article.update_attributes(article_params)
        flash[:info] = 'Article updated!'
        redirect_to article_path(@article)
      else
        flash[:alert] = @articles.errors.full_messages.to_sentence
        redirect_to article_path(@article)
      end
    end
  end

  def destroy
    @article = Article.find_by_slug(params[:slug])
    puts '=== Destroy? ==='
    if has_access # need to call after @article defined
      puts '=== HAS ACCESS TO DESTROY ==='
      if @article.destroy
        puts 'destroyed'
        flash[:info] = "Article \"#{@article.title}\" deleted successfully!"
        redirect_to articles_path
      else
        puts 'NOT destroyed'
        flash[:alert] = @article.errors.full_message.to_sentence
        redirect_to article_path(@article)
      end
    end
  end
  
  private

  def article_params
    params.require(:article).permit(:title, :slug, :category, :content)
  end

  # Used in Nav to show active item
  def set_page
    @articlespage = 'active'
  end

  # Checks if User has access to make change to Article
  def has_access(**args)
    skip_redirect = !args[:skip_redirect].nil? ? args[:skip_redirect] : false
    # If Admin, or owns current Article
    if user_signed_in?
      puts '=== user signed in ==='
      if current_user.has_roles?(:admin) || @article.user_id == current_user.id
        puts '=== admin, or owner of article ==='
        @crud_access = true
      else
        @crud_access = false
      end
      if !skip_redirect && !@crud_access
        flash[:alert] = "Access Denied!"
        redirect_to articles_path and return false
      end
      return true
    end
  end
end
