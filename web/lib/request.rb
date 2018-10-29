# frozen_string_literal: true

class Request
  class << self
    #
    # Fetchs json from Tree API.
    # raises Exception if when upstream is nil
    #
    def get(upstream)
      raise ArgumentError, 'Upstream is required.' if upstream.nil?

      retries ||= 0
      response = api.get(upstream)
      OpenStruct.new(
        status: response.status,
        content: JSON.parse(response.body, symbolize_names: true)
      )
    rescue JSON::ParserError
      # TODO: Move retry to applicaiton.yml
      retry if (retries += 1) < 3
    end

    def api
      Tree.api
    end
  end
end
