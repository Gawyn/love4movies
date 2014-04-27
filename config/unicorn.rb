unicorn_env = :production
unicorn_rack_env = :deployment

pid "/home/rails/love4movies/shared/pids/unicorn.pid"
worker_processes 4

app_ath = "/home/rails/love4movies/current"
unicorn_bin = "/etc/init.d/unicorn"
unicorn_pid = "/home/rails/love4movies/shared/pids/unicorn.pid"
unicorn_default_pid = "/home/rails/love4movies/shared/pids/unicorn.pid"
