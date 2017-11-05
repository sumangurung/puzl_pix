set :application, "puzlpix_production"
set :deploy_to, "/var/www/html/#{fetch :application}"
set :server_name, "www.puzlpix.com"
set :rails_env, 'production'
set :stage, "production"
set :branch, "master"

role :app, %w{ec2-user@puzlpix.com}
role :web, %w{ec2-user@puzlpix.com}
role :db,  %w{ec2-user@puzlpix.com}


set :ssh_options, {
  keys: %w(~/.ssh/id_rsa_puzlpix-bitbucket ~/.ssh/Superclass.pem),
  forward_agent: true,
  auth_methods: %w(publickey)
}
