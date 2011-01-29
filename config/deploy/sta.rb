set :deploy_to, "/doublerecall/dashboard"
set :branch, "master"
set :use_sudo, false
set :user, "deploy"
set :rails_env, "staging"
server "sta.disru.pt:900", :app, :web, :db, :primary => true