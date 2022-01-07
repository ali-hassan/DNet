# config valid only for current version of Capistrano
lock "3.11.0"

set :application, 'DNet'
set :repo_url, 'git@github.com:ali-hassan/DNet.git'

set :deploy_to, '/home/ubuntu/www/DNet'

set :rvm_ruby_version, '2.7.2'

set :linked_files, %w{config/secrets.yml config/database.yml config/newrelic.yml config/application.yml}

set :linked_dirs, %w{pem bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

# puma configuration
set :ssh_options,     { forward_agent: true}
set :deploy_via, :copy

set :pty, false

