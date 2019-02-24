# config valid only for current version of Capistrano
lock "3.11.0"

set :application, 'forex_home_trade'
set :repo_url, 'git@bitbucket.org:ali-hassan-mirza/forex_home_trade.git'

set :deploy_to, '/home/ubuntu/www/forex_home_trade'

set :rvm_ruby_version, '2.4.2'

set :linked_files, %w{config/secrets.yml config/database.yml config/newrelic.yml config/application.yml}

set :linked_dirs, %w{pem bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

# puma configuration
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }

set :pty, true