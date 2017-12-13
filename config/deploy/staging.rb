set :application, "puzlpix_staging"
set :deploy_to, "/var/www/html/#{fetch :application}"
set :server_name, "staging.puzlpix.com"
set :rails_env, 'staging'
set :stage, "staging"
set :branch, "master"
