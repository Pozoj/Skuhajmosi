require 'bundler/capistrano'
require "./config/capistrano_extra"

default_run_options[:pty] = true  # Must be set for the password prompt from git to work

set :application, "Skuhajmo.si"
set :repository,  "git@github.com:mihar/Skuhajmosi.git"
set :scm, :git
set :scm_verbose, true
set :deploy_via, :remote_cache
set :deploy_to, "/webroot/skuhajmosi"
set :branch, "master"
set :use_sudo, false
set :user, "deploy"
set :rails_env, "production"
server "racker-deploy", :app, :web, :db, :primary => true

ssh_options[:compression] = "none"


# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :link_rvmrc do
     run "ln -s #{shared_path}/rvmrc #{latest_release}/.rvmrc"
     run "ln -s #{shared_path}/config/setup_load_paths.rb #{latest_release}/config/setup_load_paths.rb"
   end
end

task :uname do
  run "uname -a"
end

# Hoptoad
require 'hoptoad_notifier/capistrano'
after "deploy:update", "deploy:notify_hoptoad"
# Link rvm.
after "deploy:update", "deploy:link_rvmrc"
