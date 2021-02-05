class SessionController < ApplicationController
    skip_before_action :verified_user, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.find_by(email: params[:email])
        return head(:forbidden) unless @user.try(:authenticate, params[:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    end    

    def destroy
        session.delete("user_id")
        redirect_to root_path
    end

    private 

    def auth
        request.env['omniauth.auth']
    end
end
