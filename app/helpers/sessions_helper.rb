module SessionsHelper
  def deny_access
    redirect_to log_in_path, :notice => "Prijavite se da bi pristupili ovoj stranici."
  end

  def logged_in?
    !current_user.nil?
  end
end

