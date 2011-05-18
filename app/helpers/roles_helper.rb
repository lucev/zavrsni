module RolesHelper
  def member?(user = current_user)
    user.is_a? Member
  end
end

