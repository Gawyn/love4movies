require 'capistrano-unicorn'

# RVM
set :rvm_ruby_version, "2.0.0"
set :rvm_type, :system
set :rvm_install_with_sudo, true
set :rvm_custom_path, '/usr/local/rvm/bin'

set :application, "love4movies"
set :repository,  "git@github.com:Gawyn/love4movies.git"
set :branch, 'production'
set :rails_env, "production"
set :deploy_to, "/home/rails/love4movies"
set :keep_releases, 5
set :bundle_without, [:development, :test, :test_ssl]
set :scm, :git
server "love4movies.com", :app, :web, :db, :runner, primary: true

# Users
set :use_sudo, false
_cset :user, "deployer"

# Misc
set :config_files, ['config/database.yml', 'config/app.yml', 'config/sidekiq.yml']
default_run_options[:pty] = true
ssh_options[:forward_agent] = true


# Callbacks
before 'deploy:update_code', "sidekiq:stop"
after "deploy:update_code", "deploy:cleanup"
after "deploy:update_code", 'deploy:symlink_config'
after 'deploy:restart', 'unicorn:restart'

require './config/boot'
