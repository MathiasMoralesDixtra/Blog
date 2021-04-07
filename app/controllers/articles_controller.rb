class ArticlesController < ApplicationController

    before_action :find_article, except: [:new,:create,:index]
    before_action :authenticate_user!, only: [:new,:create,:edit,:update,:destroy]

    def index
        @articles = Article.all
    end

    def show 
    end

    def edit
    end

    def update
        @article.update(article_params)
        redirect_to @article
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
    
        if @article.save
          redirect_to @article
        else
          render :new
        end
    end

    def destroy
        @article.destroy
        redirect_to root_path
    end

    def find_article
        @article = Article.find(params[:id])
    end

    private
    def article_params
      params.require(:article).permit(:title, :content)
    end
end
