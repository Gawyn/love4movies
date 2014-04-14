source 'https://rubygems.org'

# Rails
gem 'rails', '4.0.0'

# HTTParty
gem 'httparty'

# Devise
gem 'devise'

# Omniauth
gem 'omniauth-facebook'

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
gem 'sidekiq'

# Pagination
gem 'kaminari'

# Sinatra - Needed for Sidekiq web
gem 'sinatra', require: false

# Assets
gem 'sass-rails',   '~> 4.0.0'
gem "compass-rails"
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'slim-rails'
gem 'font-awesome-rails'

# Development
group :development do
  gem 'quiet_assets'
  gem 'thin'
  gem 'capistrano', "2.15.5"
  gem 'capistrano-ext'
  gem 'capistrano-unicorn', require: false
  gem 'rvm-capistrano'
  gem 'capistrano_colors', :require => false
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
