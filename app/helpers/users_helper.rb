module UsersHelper
  def options_for_user_types
    options_for_select [
      (:member),
      (:user)
    ]
  end
end

