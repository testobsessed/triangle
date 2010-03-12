set :application, "set your application name here"
set :repository,  "set your repository location here"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

# ===================================================================
# ENVIRONMENT CONFIGURATION
# ===================================================================

if  exists?(:staging) # If the environment is staging
  set :rails_env, :staging

  role :app, 192.168.1.107
  role :web, 192.168.1.107
  role :db,  192.168.1.107, :primary => true
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

