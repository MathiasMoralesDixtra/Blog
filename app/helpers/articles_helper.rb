module ArticlesHelper

    def is_article_author(article)
        user_signed_in? && article.user.email === current_user.email 
    end
end
