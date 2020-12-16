class UsersController < ApplicationController
  skip_before_action :verified_user, only: [:new, :create, :omniauth]

  def index
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    (@user = User.new(user_params))
    session[:user_id] = @user.id
    @user.save!
    render 'users/show'
  end

  def omniauth
    @user = User.find_or_initialize_by(
        email: auth['info']['email']
      )
    if !@user.email
      @user.name = auth['info']['name']
      @user.email = auth['info']['email']
      @user.password = SecureRandom.hex(10)
      @user.phone_number = auth['info']['phone']
      @user.uid = auth['uid']
    end
      @user.save!
      session[:user_id] = @user.id
      redirect_to user_path(@user)
  end

  def omniauth
    @user = User.find_or_initialize_by(
        email: auth[:info][:email]
      )
    if !@user_id
      @user.email = auth['info']['email']
      @user.name = auth[:info][:name]
      @user.email = auth[:info][:email]
      @user.password = SecureRandom.hex(10)
      @user.phone_number = auth[:info][:phone]
      @user.uid = auth[:uid]
      @user.save!
    end
      @user.save!
      session[:user_id] = @user.id
      redirect_to user_path(@user)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])        
  end

  def update
      @user = User.find_by(id: params[:id])
      @user.update(user_params)
      redirect_to user_path(@user.id)
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to '/static/home'
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
