# frozen_string_literal: true

class Tree
  def self.api
    tree_endpoint = $configs['lib']['endpoint']
    Faraday.new(url: tree_endpoint) do |conn|
      conn.response :logger if $env != :test
      conn.headers['Content-Type'] = 'application/json'
      conn.adapter Faraday.default_adapter
    end
  end
end
