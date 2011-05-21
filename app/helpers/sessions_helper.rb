module SessionsHelper
  def deny_access
    redirect_to log_in_path, :notice => "Prijavite se da bi pristupili ovoj stranici."
  end
end

