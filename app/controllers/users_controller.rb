class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You've successfully created a user!"
      log_in!(@user)
      redirect_to user_url(@user)
    else
      fail
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
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
