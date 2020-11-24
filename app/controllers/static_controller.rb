class StaticController < ApplicationController
    skip_before_action :unverified_user, only: [:home]

    def home
    end

end
