source 'https://rubygems.org'

ruby "2.2.3"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

gem 'activeadmin', github: 'gregbell/active_admin'
gem 'devise'
gem 'cancan'
gem 'draper'
gem 'pundit'
gem 'kaminari'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt'

# Faker, a port of Data::Faker from Perl, is used to easily generate fake data: names, addresses, phone numbers, etc.
gem 'faker', '~> 1.5.0'

# Upload files in your Ruby applications, map them to a range of ORMs, store them on different backends.
gem 'carrierwave', '~> 0.10.0'

# Manipulate images with minimal use of memory via ImageMagick / GraphicsMagick
gem 'mini_magick', '~> 4.3.6'

# The Ruby cloud services library. Supports all major cloud providers including AWS, Rackspace, Linode, Blue Box, StormOnDemand, and many others. Full support for most AWS services including EC2, S3, CloudWatch, SimpleDB, ELB, and RDS.
gem 'fog', '~> 1.34.0'

# will_paginate provides a simple API for performing paginated queries with Active Record, DataMapper and Sequel, and includes helpers for rendering pagination links in Rails, Sinatra and Merb web apps.
# gem 'will_paginate', '~> 3.0.7'
# gem 'will_paginate', "3.0.pre2"

# Hooks into will_paginate to format the html to match Twitter Bootstrap styling. Extension code was originally written by Isaac Bowen (https://gist.github.com/1182136).
# gem 'bootstrap-will_paginate', '~> 0.0.10'

# Twitter's Bootstrap, converted to Sass and ready to drop into Rails or Compass
gem 'bootstrap-sass', '~> 3.3.5.1'

gem 'font-awesome-sass', '~> 4.4.0'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  # Pg is the Ruby interface to the {PostgreSQL RDBMS}
  gem 'pg',             '~> 0.18.3'
  
  # This gem enables serving assets in production and setting your logger to standard out
  gem 'rails_12factor', '~> 0.0.3'
  
  # Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications.
  # Puma is intended for use in both development and production environments. 
  # In order to get the best throughput, it is highly recommended that you use a Ruby implementation with real threads like Rubinius or JRuby.
  gem 'puma', '~> 2.14.0'
end