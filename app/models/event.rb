class Event < ActiveRecord::Base
  has_many :participations
  has_many :users, :through => :participations

  def applied? (user)
    if user.nil?
      return false
    end
    if self.users.find_by_id(user.id)
      return true
    else
      return false
    end
  end

end

