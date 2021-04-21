class Article < ApplicationRecord
    has_rich_text :content
    has_many :comments
    has_many :has_categories
    has_many :categories, through: :has_categories
    belongs_to :user
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }
    attr_accessor :category_elements
    def save_categories
        return has_categories.destroy_all if category_elements.nil? || category_elements.empty?
        has_categories.where.not(category_id: category_elements).destroy_all
        #category_elements 1,2,3
        # Iterar Arreglo
        category_elements.each do |category_id|
        # Crear HasCategory
            HasCategory.find_or_create_by(article: self, category_id: category_id)
        end
    end
end
