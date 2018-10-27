require './config/loaders'

$configs = YAML::load(File.read('./config/application.yml'))[$env.to_s]

require './config/require_all'
require 'logger'

class App < Sinatra::Base

  configure do
    enable :logging
    $logger = Logger.new("#{settings.root}/log/#{settings.environment}.log", 'daily')
    use Rack::CommonLogger, $logger
  end

  use Rack::Parser, parsers: {
    'application/json' => proc do |data|
      JSON.parse(data)
    end
  }

  use HomeController
  # use API::AuthController

  run! if app_file == $0
end
