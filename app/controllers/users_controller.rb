class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:new, :create]
    before_action :find_user, only: [:edit, :update, :destroy, :password_edit, :password_update]
    
    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            render :new
        end
    end

    def edit
        if @user.id != session[:user_id]
            redirect_to root_path, notice: "Not Aurthorized, Access Denied!"
        end
    end

    def update
        if @user.id != session[:user_id]
            redirect_to root_path, notice: "Not Aurthorized, Access Denied!"
        else
            if @user.update user_params
                redirect_to edit_user_path, notice: "User Information Updated Succesfully"
            else
                flash[:alert] = "Oops! Update failed try again"
                render :edit
            end
        end
    end

    def password_edit
        if @user.id != session[:user_id]
            redirect_to root_path, notice: "Not Aurthorized, Access Denied!"
        end
    end

    def password_update
        if @user.id != session[:user_id]
            redirect_to root_path, notice: "Not Aurthorized, Access Denied!"
        else
            if @user&.authenticate params[:user][:current_password]
                if params[:user][:new_password] == params[:user][:new_password_confirmation]
                    if @user.update password: params[:user][:new_password], password_confirmation: params[:user][:new_password_confirmation]
                        session[:user_id] = nil
                        redirect_to root_path, notice: "Password has been changed successfully. Plase Log-in Again"
                    else
                        flash[:alert] = "Ooops! Password update failed. Try again"
                        render :password_edit
                    end
                else
                    flash[:alert] = "Password again does not match"
                    render :password_edit, notice: "Password again does not match"
                end
            else
                flash[:alert] = "Current Password is wrong"
                render :password_edit
            end
        end
    end

    def destroy
        session[:user_id] = nil
        @user.destroy
        redirect_to root_path
    end

    private
    def user_params
        params.require(:user).permit(
            :first_name, :last_name, :email, :password, :password_confirmation
        )
    end

    def find_user
        @user=User.find_by id:params[:id]
        if @user == nil
            redirect_to root_path, notice: "User Id Does Not Exist"
        end
    end
end
