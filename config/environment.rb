# Load the rails application
require File.expand_path('../application', __FILE__)

Mime::Type.register "text/calendar", :ical
Paperclip.options[:command_path] = "/usr/bin/"
Paperclip::Railtie.insert
# Initialize the rails application
Tigris::Application.initialize!

