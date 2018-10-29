class TreeController < ApplicationController

  #
  # Endpoint responsible to filter all API data using indicator_ids.
  # 
  # Calling example: /tree/input?indicator_ids[]=31&indicator_ids[]=32&indicator_ids[]=1
  #
  get '/tree/?:name?' do
    request = TreeRequest.new(params)
    request.validate_upstream!
    response = TreeService.new(request.to_hash).perform
    halt_data(200, response.content)
  end
end