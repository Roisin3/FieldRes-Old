class SessionController < ApplicationController
   skip_before_action :unverified_user, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.find_by(email: params[:email])
        return head(:forbidden) unless @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    end

    def omniauth
        user = User.from_omniauth(auth)

        if user.valid?
            login(user)
            flash[:success] = "Successfully logged in via #{auth[:provider]}"
            redirect_to user_path(user)
        else
            flash[:danger] = user.errors.full_message.join(", ")
            redirect_to '/'
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
