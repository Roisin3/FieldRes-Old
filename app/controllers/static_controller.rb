class StaticController < ApplicationController
    skip_before_action :verified_user
    def home
    end

    def show
    end

end
