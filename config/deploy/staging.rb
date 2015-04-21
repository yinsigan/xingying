set :user, 'yinsigan'
set :domain, 'staging.dev-start.net'
set :deploy_to, '/home/yinsigan/xy_staging'
set :repository, 'git@bitbucket.org:yinsigan/xingying.git'
set :branch, 'develop'
set :term_mode, nil
set :rails_env, 'production'
set :unicorn_config, -> { "#{deploy_to}/#{current_path}/config/unicorn/staging.rb" }
set :bundle_gemfile, -> { "#{deploy_to}/#{current_path}/Gemfile" }
set :unicorn_pid,  -> { "#{deploy_to}/#{current_path}/tmp/pids/unicorn.pid"  }