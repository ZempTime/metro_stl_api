set :stage, :production

server '107.170.159.236', user: 'deploy', roles: %w{web app}
