class AddDraftToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :draft, :boolean
  end
end
