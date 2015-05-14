class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user

  def log_in!(user)
    token = user.reset_session_token!
    session[:session_token] = token
  end

  def current_user
    user = User.find_by_session_token(session[:session_token])
    if user
      user
    else
      nil
    end
  end
end
