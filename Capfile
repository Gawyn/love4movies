load 'deploy'
load 'config/deploy'
load 'deploy/assets'

Dir['config/recipes/*.rb'].each { |recipe| load(recipe) }

require 'capistrano_colors'
require "rvm/capistrano"
require 'capistrano_colors'
require 'bundler/capistrano'
require 'sidekiq/capistrano'
require 'capistrano-unicorn'
