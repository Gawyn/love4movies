set :application, "love4movies"
set :repository,  "git@github.com:Gawyn/love4movies.git"
set :branch, 'production'
set :rails_env, "production"
set :deploy_to, "/home/rails/love4movies"
set :keep_releases, 5
set :bundle_without, [:development, :test, :test_ssl]

set :scm, :git

# Sidekiq

# Users
set :use_sudo, false
_cset :user, "deployer"

# Misc
set :config_files, ['config/database.yml', 'config/app.yml', 'config/sidekiq.yml']
default_run_options[:pty] = true
ssh_options[:forward_agent] = true


# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "love4movies.com", :app, :web, :db, :runner, primary: true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
