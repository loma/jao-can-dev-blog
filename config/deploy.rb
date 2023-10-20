# config valid for current version and patch releases of Capistrano
lock "~> 3.18.0"

server "178.128.213.156", roles: %w{app db web}
set :application, "jao_can_dev_blog"
set :repo_url, "git@github.com:loma/jao-can-dev-blog.git"
set :user, "deploy"
set :ssh_options, forward_agent: false, user: fetch(:user)
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

namespace :deploy do
  desc "start puma"
  task :start_puma do
    on roles(:web) do
      execute 'cd /home/deploy/apps/jao_can_dev_blog/current; RAILS_ENV=production  ~/.rvm/bin/rvm default do bundle exec puma -C config/puma.rb &'
    end
  end
  after "deploy:log_revision", "deploy:start_puma"
end

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
