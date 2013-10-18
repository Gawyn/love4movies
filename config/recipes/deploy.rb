namespace :deploy do
  task(:start) {}
  task(:stop) {}

  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end

  desc "Symlinks application configuration from shared folder"
  task :symlink_config, :roles => [:app, :worker], :except => {:no_release => true} do
    commands = config_files.map do |path|
      "rm -rf #{release_path}/#{path} && ln -s #{shared_path}/#{path} #{release_path}/#{path}"
    end
    run "cd #{release_path} && #{commands.join(" && ")}"
  end
end
