# frozen_string_literal: true

class Tree
  # TODO: move config to application.yml
  BASE = 'https://kf6xwyykee.execute-api.us-east-1.amazonaws.com/production/tree'

  def self.api
    Faraday.new(url: BASE) do |conn|
      conn.response :logger if $env != :test
      conn.headers['Content-Type'] = 'application/json'
      conn.adapter Faraday.default_adapter
    end
  end
end
