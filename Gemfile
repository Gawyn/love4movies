source 'https://rubygems.org'

# Rails
gem 'rails', '4.1.1'

# HTTParty
gem 'httparty'

# Devise
gem 'devise'

# Omniauth
gem 'omniauth-facebook'
gem 'omniauth-twitter'

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

# Decoder
gem 'unidecoder'

# Assets
gem 'sass-rails', github: "rails/sass-rails"
gem 'sass', '~> 3.3.12'
gem 'compass-rails', '~> 2.0.0'
gem 'compass', '~> 1.0.0.alpha.21'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'slim-rails'
gem 'font-awesome-rails'
gem 'ionicons-rails'

# Development
group :development do
  gem 'quiet_assets'
  gem 'thin'
  gem 'capistrano', "2.15.5"
  gem 'capistrano-ext'
  gem 'capistrano-unicorn', require: false
  gem 'rvm-capistrano'
  gem 'capistrano_colors', :require => false
  gem 'byebug'
end

# Development & Test
group :development, :test do
  gem 'sqlite3'
end

# Production
group :production do
  gem 'pg'
  gem 'unicorn'
end

# Development & Production
group :development, :production do
  gem 'sunspot_solr'
end
