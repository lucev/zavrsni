# Load the rails application
require File.expand_path('../application', __FILE__)

Mime::Type.register "text/calendar", :ical

# Initialize the rails application
Tigris::Application.initialize!

