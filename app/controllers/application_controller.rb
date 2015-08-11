class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_user

  def logged_in_user
    session[:user_id] ? User.find(session[:user_id]) : User.guest_user
  end

end
