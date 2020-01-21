class ApplicationController < ActionController::Base

    # If User is not signed in it will send to sign_in page
    def authenticate_user!
        redirect_to new_session_path, notice: "Please Sign in" unless user_signed_in?
    end
    
    # Check is user signed in or not
    def user_signed_in?
        current_user.present?
    end
    helper_method :user_signed_in?
    
    # Logged in User will be == to current_user
    def current_user
        @current_user ||= User.find_by_id session[:user_id]
    end
    helper_method :current_user
end
