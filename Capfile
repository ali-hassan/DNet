# Load DSL and set up stages
require 'capistrano/setup'
require 'capistrano/deploy'

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
# require "capistrano/rails/assets"
require 'capistrano/rvm'
require 'capistrano/ssh_doctor'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
# require 'capistrano/npm'
# require 'thinking_sphinx/capistrano'
require "capistrano/rails/migrations"
require "capistrano/passenger"
require 'capistrano/sidekiq'
# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
