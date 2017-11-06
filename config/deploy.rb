set :repo_url,  "git@puzlpix-bitbucket.org:superclassllc/puzlpix_web.git"
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

before 'deploy:starting', 'setup:upload_yml'
after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:stop'
    invoke 'unicorn:reload'
  end

  task :stop do
    invoke 'unicorn:stop'
  end
end

set :ssh_options, {
  keys: %w(~/.ssh/id_rsa_puzlpix-bitbucket ~/.ssh/Superclass.pem),
  forward_agent: true,
  auth_methods: %w(publickey)
}
