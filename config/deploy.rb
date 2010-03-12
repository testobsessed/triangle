set :application, "triangle"
set :repository,  "git@github.com:ehendri/triangle.git"
set :scm, "git"

# Determine which branch to be checked out
set :branch, "master"


# ===================================================================
# ENVIRONMENT CONFIGURATION
# ===================================================================

set :deploy_to, "/Library/WebServer/Documents/triangle"

if  exists?(:staging) # If the environment is staging
  set :rails_env, :staging

  role :app, "192.168.1.107"
  role :web, "192.168.1.107"
  role :db,  "192.168.1.107", :primary => true
end

# ===================================================================
# TASKS
# ===================================================================

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

task :after_deploy do
end

task :after_setup do
end

