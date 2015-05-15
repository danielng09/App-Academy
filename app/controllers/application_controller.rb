class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user

  def log_in_user!(user)
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

  def logged_in?
    !current_user.nil?
  end

  def log_out_user!(user)
    session[:session_token] = nil
    user.reset_session_token!
  end

  def redirect_to_sign_up_unless_signed_in
    unless logged_in?
      redirect_to new_session_url
    end
  end

  def cant_sign_up_if_logged_in
    if logged_in?
      redirect_to bands_url
    end
  end
end
