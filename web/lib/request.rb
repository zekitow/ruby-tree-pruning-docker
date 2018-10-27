class Request
  class << self

    #
    # Fetchs json from Tree API.
    # raises Exception if when upstream is nil
    #
    def fetch_json(upstream)
      raise ArgumentError.new("Upstream is required.") if upstream.nil?
      response = api.get(upstream)
      [JSON.parse(response.body), response.status]
    end

    def api
      Tree.api
    end
  end
end