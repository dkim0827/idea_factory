class ReviewsController < ApplicationController
    before_action :authenticate_user!
        
    def create 
        @idea = Idea.find(params[:idea_id])
        @new_review = Review.new review_params
        @new_review.user = current_user
        @new_review.idea = @idea
        if @new_review.save
            redirect_to idea_path(@idea)
        else
            @reviews = @idea.reviews.order(created_at: :desc)
            render 'idea/show'
        end
    end

    def destroy 
        @review = Review.find(params[:id])
        if can? :crud, @review
            @review.destroy
            redirect_to idea_path(@review.idea)
        else
            redirect_to root_path, alert: "Not Authorized. Access Denied"
        end
    end

    private 

    def review_params 
        params.require(:review).permit(:body)
    end
end
    
