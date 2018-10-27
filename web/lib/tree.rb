class Tree
  # TODO: move config to application.yml
  BASE = "https://kf6xwyykee.execute-api.us-east-1.amazonaws.com/production/tree"

  def self.api
    Faraday.new(url: BASE) do |faraday|
      faraday.response :logger
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end
  end
end