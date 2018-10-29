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
      max_retries ||= $configs['lib']['max_retries']
      retry if (retries += 1) < max_retries
    end

    def api
      Tree.api
    end
  end
end
