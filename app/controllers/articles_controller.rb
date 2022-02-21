class ArticlesController < ApplicationController
  before_action :authorized, only: [:get, :getById, :create, :update, :delete]

  def get
    @articles = Article.all

    render :json => {
      :success => true,
      :articles => @articles.map { |article|
        {
          :id => article.id,
          :title => article.title,
          :body => article.body
        }
      }
    }
  end

  def getById
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      render :json => {
        :success => false,
        :error => "Article with ID: #{params[:id]} not found"
      }
      return
    end

    render :json => {
      :success => true,
      :id => @article.id,
      :title => @article.title,
      :body => @article.body
    }
    return
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      render :json => {
        :success => true,
        :id => @article.id,
        :title => @article.title,
        :body => @article.body
      }
      return
    end

    render :json => {
      :success => false,
      :error => @article.errors.full_messages.join(", ")
    }
    return
  end

  def update
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      render :json => {
        :success => false,
        :error => "Article with ID: #{params[:id]} not found"
      }
      return
    end

    if @article.update(article_params)
      render :json => {
        :success => true,
        :id => @article.id,
        :title => @article.title,
        :body => @article.body
      }
    else
      render :json => {
        :success => false,
        :error => @article.errors.full_messages.join(", ")
      }
    end
  end

  def delete
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      render :json => {
        :success => false,
        :error => "Article with ID: #{params[:id]} not found"
      }
      return
    end

    @article.destroy

    render :json => {
      :success => true
    }
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
