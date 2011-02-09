set :deploy_to, "/webroot/skuhajmo"
set :branch, "master"
set :use_sudo, false
set :user, "deploy"
set :rails_env, "development"
server "devas.disru.pt:910", :app, :web, :db, :primary => true