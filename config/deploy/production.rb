set :application, "puzlpix_production"
set :deploy_to, "/var/www/html/#{fetch :application}"
set :server_name, "www.puzlpix.com"
set :rails_env, 'production'
set :stage, "production"
set :branch, "master"
