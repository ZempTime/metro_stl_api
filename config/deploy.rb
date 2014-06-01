# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'metro_stl_api'
set :repo_url, 'git@github.com:trenchwarfare/metro_stl_api.git'

set :deploy_to, '/home/deploy/metro_stl_api'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :finishing, 'deploy:cleanup'
end
