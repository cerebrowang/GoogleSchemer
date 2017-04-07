source 'https://rubygems.org'

ruby "2.3.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

# Assets
gem 'autoprefixer-rails'
gem 'i18n-js'
gem 'jquery-turbolinks'
gem 'twbs_sass_rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem "devise"
gem "devise_invitable"
gem "cancan"

gem 'geocoder'

group :production do
  # Use postgresql as the database for Active Record
  gem 'pg'
  # Rails 12factor
  # Makes running your Rails app easier. Based on the ideas behind 12factor.net
  # Needed for support of Asset Pipeline with Heroku
  # https://github.com/heroku/rails_12factor
  gem 'rails_12factor'
  gem 'rack-timeout'  
end

# Core dependencies, pulled from master
gem 'omniauth', :git => 'git://github.com/intridea/omniauth.git'
gem 'omniauth-oauth2', :git => 'git://github.com/intridea/omniauth-oauth2.git'

# For testing/comparison
gem 'omniauth-github', :git => 'git://github.com/intridea/omniauth-github.git'
gem 'omniauth-google-oauth2'
# gem "omniauth-douban", :git => "git://github.com/ballantyne/omniauth-douban.git"

gem 'figaro'
gem "rolify"
gem 'bootstrap-sass'
gem "will_paginate"

gem 'twitter-typeahead-rails', :git => "git://github.com/yourabi/twitter-typeahead-rails.git"
gem 'handlebars_assets'

gem 'carrierwave'
gem 'carrierwave-qiniu'
gem 'rmagick', '~> 2.16.0'

gem 'acts-as-taggable-on', '~> 4.0'

# Servers
gem 'puma', '~> 3.8.2'

gem 'json', '~> 1.8.3'

# App monitoring
# gem 'airbrake'
gem 'newrelic_rpm'