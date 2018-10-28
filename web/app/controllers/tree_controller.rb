class TreeController < ApplicationController

  #
  # Endpoint responsible to filter all API data using indicator_ids.
  # 
  # Calling example: /tree/input?indicator_ids[]=31&indicator_ids[]=32&indicator_ids[]=1
  get '/tree/?:name?' do
    halt_with(404, "Invalid upstream") if params["name"].nil?
    response = TreeService.new(extract_params).perform
    halt_with(404, response.content[:error]) if response.status == 404
    halt_data(200, response.content)
  end

  private 
    def extract_params
      indicators = params["indicator_ids"] || []
      indicators.map! {| i | i.to_i }
      { name: params["name"], indicator_ids: indicators }
    end
end