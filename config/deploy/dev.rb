set :deploy_to, "/doublerecall/dashboard"
set :branch, "master"
set :use_sudo, false
set :user, "deploy"
set :rails_env, "development"
server "dev.disru.pt:910", :app, :web, :db, :primary => true