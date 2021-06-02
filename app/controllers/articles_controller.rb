class ArticlesController < ApplicationController

    before_action :find_article, except: [:new,:create,:index,:from_author,:drafts]
    before_action :control_edit, only: [:edit, :update]
    before_action :control_draft_owner, only:[:show]
    before_action :find_user, only: [:from_author]
    before_action :authenticate_user!, only: [:new,:create,:edit,:update,:destroy]
    before_action :editor_only, only: [:new, :edit, :update, :destroy]

    def index
        @owners = User.all
        filter = {draft:[nil,false]}
        filter[:user_id] = params[:user_id] if params[:user_id].present?
        filter[:created_at] = params[:created_at].to_date.all_day if params[:created_at].present?
        @articles = Article.where(filter).page(params[:page]).per(3)
    end

    def show 
    end

    def edit
        @categories = Category.all
    end

    def update
        @article.update(article_params)
        @article.save_categories
        redirect_to @article
    end

    def new
        @article = Article.new
        @categories = Category.all
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
    
        if @article.save
            @article.save_categories
            redirect_to @article
        else
          render :new
        end
    end

    def destroy
        @article.destroy
        redirect_to root_path
    end

    def from_author
    end

    def drafts
        @articles = Article.where(draft: true, user_id: current_user.id )
    end

    private
    def find_article
        @article = Article.find(params[:id])
    end

    def control_edit
        unless @article.user_id === current_user.id 
            flash[:notice] = "Esta de vivo #{current_user.email}"
            redirect_to root_path 
        end
    end

    def control_draft_owner
        if @article.draft? && @article.user_id != current_user.id 
            flash[:alert] = "Esta de vivo #{current_user.email}"
            redirect_to root_path 
        end
    end


    def find_user
        @user = User.find(params[:user_id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :draft, category_elements: [])
    end
end
