set :linked_files, %w{config/secrets.yml config/database.yml}


require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/rvm"
require "capistrano/bundler"
require "capistrano3/unicorn"
# require 'capistrano/rails'
# require "capistrano/rails/assets"
require 'capistrano/rails/migrations'
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
