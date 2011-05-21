class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  private

  def authenticate
    deny_access unless current_user
  end

  def deny_access
    redirect_to log_in_path, :notice => "Prijavite se da bi pristupili ovoj stranici."
  end
end

