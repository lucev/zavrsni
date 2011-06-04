# Load the rails application
require File.expand_path('../application', __FILE__)
require 'will_paginate'
Mime::Type.register "text/calendar", :ical
Paperclip.options[:command_path] = "/usr/bin/"
Paperclip::Railtie.insert
# Initialize the rails application
Tigris::Application.initialize!
WillPaginate::ViewHelpers.pagination_options[:prev_label] = 'Prethodna'
WillPaginate::ViewHelpers.pagination_options[:next_label] = 'Sljedeća'

