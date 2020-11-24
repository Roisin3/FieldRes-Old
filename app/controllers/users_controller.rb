class UsersController < ApplicationController
  skip_before_action :unverified_user, only: [:new, :create, :omniauth, :auth]

  def index
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    (user = User.new(user_params))
    session[:user_id] = user.id
    render 'users/show'
  end

  def omniauth
    @user = User.find_or_initialize_by(
      email: auth[:info][:email], 
      name: auth[:info][:name], 
      password_digest: SecureRandom.hex(10), 
      phone_number: auth['info']['phone'], 
      uid: auth[:uid]
      )
      session[:user_id] = @user.id
      @user.save
    render 'users/show'
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: current_user.id)        
  end

  def update
      @user = User.find_by(id: params[:id])
      @user.update(user_params)
      redirect_to user_path(@user.id)
  end


  private

  def user_params
      params.require(:user).permit(
          :name, :password, :email, :phone_number, :uid
          )
  end

  def auth
    request.env['omniauth.auth']
  end

end
