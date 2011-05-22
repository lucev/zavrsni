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

# Convert to iCalendar
  def to_ics
    event = Icalendar::Event.new
    event.start = self.start_date.strftime("%Y%m%dT%H%M%S")
    event.end = self.end_date.strftime("%Y%m%dT%H%M%S")
    event.summary = self.name
    event.description = self.description
    event.location = self.location
    event.klass = "PUBLIC"
#    event.created = self.created_at
#    event.last_modified = self.updated_at
    event.uid = event.url = "#{PUBLIC_URL}events/#{self.id}"
    event
  end

end

