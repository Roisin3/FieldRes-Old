class UsersController < ApplicationController
  skip_before_action :verified_user, only: [:new, :create]

  def index
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # if 
      (user = User.create(user_params))
      session[:user_id] = user.id
      redirect_to user_path(user)
    # else
    #   user = User.create_with(:uid => auth['uid']) do |u|
    #     u.name = auth['info']['name']
    #     u.email = auth['info']['email']
    #     session[:user_id] = user.try(:id)
    #     redirect_to user_path(@user)
    #   end
    #end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])        
  end

  def update
      @user = User.find_by(id: params[:id])
      user.update(user_params)
      redirect_to user_path(user.id)
  end


  private

  def user_params
      params.require(:user).permit(
          :name, :password, :email, :phone_number, :uid
          )
  end

end
