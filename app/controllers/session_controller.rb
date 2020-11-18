class SessionController < ApplicationController
    skip_before_action :verified_user, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        if auth_hash = request.env['omniauth.auth']
            @user = User.find_or_create_by_omniauth(auth_hash)
            session[:user_id] = @user.id
        else
            @user = User.find_by(email: params[:email])
        end
        session[:user_id] = @user.id
        @user.save!
        render '/users/show'
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
