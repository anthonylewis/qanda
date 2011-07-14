
set :application, "qanda"
set :user, 'tony'

set :deploy_to, "/home/tony/qanda"

set :scm, :git
set :repository,  "git@github.com:anthonylewis/qanda.git"

default_run_options[:pty] = true
set :deploy_via, :remote_cache

set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false

role :web, "50.56.107.232"                     # Your HTTP server, Apache/etc
role :app, "50.56.107.232"                     # This may be the same as your `Web` server
role :db,  "50.56.107.232", :primary => true   # This is where Rails migrations will run

set :default_environment, {
  'PATH' => "/home/tony/.rvm/gems/ruby-1.9.2-p180@railsclass/bin:/home/tony/.rvm/gems/ruby-1.9.2-p180@global/bin:/home/tony/.rvm/rubies/ruby-1.9.2-p180/bin:/home/tony/.rvm/bin:$PATH",
  'RUBY_VERSION' => 'ruby-1.9.2-p180',
  'GEM_HOME' => '/home/tony/.rvm/gems/ruby-1.9.2-p180@railsclass',
  'GEM_PATH' => '/home/tony/.rvm/gems/ruby-1.9.2-p180@railsclass:/home/tony/.rvm/gems/ruby-1.9.2-p180@global',
}

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :rvm do
  desc 'Trust rvmrc file'
  task :trust_rvmrc do
    run "rvm rvmrc trust #{current_release}"
  end
end
 
after "deploy:update_code", "rvm:trust_rvmrc"
