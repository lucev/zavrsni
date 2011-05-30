class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :authorized_for

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

  def admin?
    current_user.admin?
  end

  def authorized_for object
    return false if current_user.nil?
    if object.class == User or object.class == Member
      current_user.admin? or object.id == current_user.id
    elsif object.class == Event
      current_user.admin?
    else
      current_user.admin? or object.user_id == current_user.id
    end
  end
end

