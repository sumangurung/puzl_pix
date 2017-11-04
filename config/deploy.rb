set :application, "puzlpix"
set :repo_url,  "git@puzlpix-bitbucket.org:superclassllc/puzlpix_api.git"
set :deploy_to,  "/var/www/html/puzlpix"
set :log_level, :debug
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
set :rvm_ruby_version, '2.2.2'
set :rvm_type, :system
set :keep_releases, 3
set :user, "ec2-user"
set :runner, "ec2-user"

role :app, %w{ec2-user@puzlpix.com}
role :web, %w{ec2-user@puzlpix.com}
role :db,  %w{ec2-user@puzlpix.com}

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart do
    invoke 'unicorn:restart'
  end
end
