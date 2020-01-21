class Idea < ApplicationRecord
    belongs_to :user
    has_many :reviews, dependent: :destroy

    has_many :likes, dependent: :destroy
    has_many :users, through: :likes

    validates :title, presence: true
    validates :description, presence: true
    
    before_validation :capitalize_title 
    
    def liked_by?(user)
        likes.find_by_user_id(user.id).present?
    end
    
    private
    def capitalize_title
        self.title.capitalize!
    end

end

