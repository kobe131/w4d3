class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  # all about authentication 
  # protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  def current_user
    return nil unless session[:session_token] 
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def logged_in?
    !!(current_user)
  end
  
  def login(user)
    @current_user = user 
    session[:session_token] ||= @current_user.reset_session_token! 
  end
  
  def logout
    session[:session_token] = nil 
    self.reset_session_token! if @current_user 
  # if you want thing to appear in the whole application, put it in the application controller 
  end
end
