class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
 
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    @article.user_id = current_user.id
   
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  before_action :authenticate_user!
  def destroy
    @user = User.find(params[:user_id])
    @article = @user.articles.find(article_params)
    @article.destroy
  
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
