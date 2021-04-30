class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :author, foreign_key: :user_id, class_name: :User 
  has_rich_text :body
end
