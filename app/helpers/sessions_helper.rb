module SessionsHelper

  def logged_in?
    !current_user.nil?
  end

   def log_in(user)
    session[:user_id] = user.id
    set_user(user)
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_session_token] = user.remember_session_token
  end

  # Returns the current loggid in user (if any)
  def current_user
    # If the user is logged in then set @current_user to the user that matches the id inside the cookie
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    # If there is no session cookie then check the permenent cookie for a user id
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      # Make sure user is authenticated before logging them in
      if user && user.authenticated?(cookies[:remember_session_token])
        log_in(user)
        @current_user = user
      end
    end
  end

  def set_user(user)
    @current_user = user
  end

  def sign_out
    session.delete(:user_id)
    cookies.delete(:remember_session_token)
    cookies.delete(:user_id)
    @current_user = nil
  end
end
