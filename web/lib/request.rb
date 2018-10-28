class Request
  class << self

    #
    # Fetchs json from Tree API.
    # raises Exception if when upstream is nil
    #
    def get(upstream)
      raise ArgumentError.new("Upstream is required.") if upstream.nil?

      begin

        retries ||= 0
        response = api.get(upstream)
        return OpenStruct.new(
          status: response.status,
          content: JSON.parse(response.body, { symbolize_names: true }))

      rescue JSON::ParserError => e
        # TODO: Move retry to applicaiton.yml
        retry if (retries += 1) < 3
      end
    end

    def api
      Tree.api
    end
  end
end