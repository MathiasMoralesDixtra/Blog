class CommentsController < ApplicationController
    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.new(comment_params.merge(user_id:current_user.id))

        if @comment.save
          redirect_to @article
      else
        render "articles/show"
      end
    end
    
      private
        def comment_params
          params.require(:comment).permit(:body)
        end
end
