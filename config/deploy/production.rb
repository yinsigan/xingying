set :user, 'yinsigan'
set :domain, 'dev-start.net'
set :deploy_to, '/home/yinsigan/xy'
set :repository, 'git@bitbucket.org:yinsigan/xingying.git'
set :branch, 'master'
set :term_mode, nil
set :rails_env, 'production'
set :puma_config,    -> { "#{deploy_to}/#{current_path}/config/puma/production.rb" }
set :bundle_gemfile, "#{deploy_to}/#{current_path}/Gemfile"