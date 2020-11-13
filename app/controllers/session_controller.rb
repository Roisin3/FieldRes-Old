class SessionController < ApplicationController
    skip_before_action :verified_user, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        if auth
            @user = User.find_or_create_by(:uid => auth['uid']) do |u|
                u.name = auth['info']['nickname']
                u.email = auth['info']['email']
                u.password = SecureRandom.uuid
                u.uid = auth['uid']
            end
            session[:user_id] = @user.id
            redirect to user_path(@user)
        else
            @user = User.find_by(email: params[:email])
            if @user.nil?
                render :new
            else
                return head(:forbidden) unless @user.authenticate(params[:password])
                session[:user_id] = @user.id
                redirect_to user_path(@user)
            end
        end
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
