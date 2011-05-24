css_dir = ENV['HEROKU_TYPE'] ? 'tmp' : 'public'
location = Rails.root + 'app/styles'

  unless Sass::Plugin.template_location_array.any? { |pair| pair.first.to_s == location.to_s }
    css_location = Rails.root + css_dir + 'stylesheets'
    Sass::Plugin.add_template_location(location.to_s, css_location.to_s)
  end

if ENV['HEROKU_TYPE']
  Sass::Plugin.template_location_array.each do |template_location, css_location|
    css_location.sub!(%r{/public/stylesheets$}, "/#{css_dir}/stylesheets")
  end

# add Rack middleware to serve compiled stylesheets from "tmp/stylesheets"
  Rails.configuration.middleware.insert_after 'Sass::Plugin::Rack', 'Rack::Static',
    :urls => ['/stylesheets'], :root => "#{Rails.root}/tmp"
end

