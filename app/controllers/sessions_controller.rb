class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
      )
    if user
      log_in_user!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = "Invalid user and password combination"
      render :new
    end

  end

  def destroy
    user = User.find_by_session_token(session[:session_token])
    log_out_user!(user)
    redirect_to users_url
  end

end
