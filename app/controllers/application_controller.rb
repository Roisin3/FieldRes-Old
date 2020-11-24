class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :unverified_user
    helper_method :current_user

    private

    def unverified_user
        redirect_to '/' unless user_is_authenticated
    end

    def user_is_authenticated
        current_user
    end

    def current_user
        current_user = User.find(session[:user_id])
    end

    
end
