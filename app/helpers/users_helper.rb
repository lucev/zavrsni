module UsersHelper
  def options_for_user_types
    options_for_select [
      %w(Član member),
      %w(Korisnik user)
    ]
  end

end

