set :stage, :production
set :rails_env, 'production'

role :web, %w{25.18.91.50}
role :app, %w{25.18.91.50}
role :db,  %w{25.18.91.50}

server '25.18.91.50', user: 'usuario', roles: %w{web app db}
