source 'http://rubygems.org'

# Rails
gem 'rails', '4.2.11.1'

# Devise
gem 'devise'

# Omniauth
gem 'omniauth-facebook', '4.0.0'
gem 'omniauth-twitter'
gem 'omniauth-rails_csrf_protection'

# Facebook
gem 'koala'

# Forms
gem 'simple_form'

# Decorator
gem 'draper'

# Internationalization
gem 'traco'

# Turbolinks
gem 'turbolinks'

# Sidekiq
gem 'sidekiq', '2.15.1'

# Sidekiq Failures
gem 'sidekiq-failures'

# Pagination
gem 'kaminari'

# Sunspot for search
gem 'sunspot_rails'

# Progress reporting for Sunspot
gem 'progress_bar'

# Sinatra - Needed for Sidekiq web
gem 'sinatra', require: false

# New Relic
gem 'newrelic_rpm'

# Simple TheMovieDB
gem 'simple_themoviedb', '0.2.1'

# Decoder
gem 'unidecoder'

# Json
gem 'json', '1.8.5'

# Assets
gem 'sass-rails', github: "rails/sass-rails"
gem 'sass', '~> 3.4.5'
gem 'compass-rails', '~> 2.0.0'
gem 'compass', '~> 1.0.1'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'slim-rails'
gem 'ionicons-rails'

# Development
group :development do
  gem 'rb-readline'
  gem 'quiet_assets'
  gem 'thin'
  gem 'capistrano', "2.15.5", require: false
  gem 'capistrano-ext', require: false
  gem 'capistrano-unicorn', require: false
  gem 'rvm-capistrano', require: false
  gem 'capistrano_colors', require: false
  gem 'byebug'
end

# Development & Test
group :development, :test do
  gem 'sqlite3'
end

# Production
group :production do
  gem 'unicorn'
end

# Development & Production
group :development, :production do
  gem 'sunspot_solr'
  gem 'pg'
end
