class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You've successfully created a user!"
      redirect_to user_url(@user)
    else

    end
  end

  def index
    @users = User.all
    render :index
  end

  def show

  end

  def update

  end

  def destroy

  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
