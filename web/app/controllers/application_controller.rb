# frozen_string_literal: true

require 'json'

class ApplicationController < Sinatra::Base
  helpers ApplicationHelper
  set :show_exceptions, false
  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, -> { File.join(root, 'views') }

  #
  # Captures all NotFoundError
  #
  error NotFoundError do
    $logger.error("Internal server error: #{env['sinatra.error']}")
    $logger.error("PATH: #{request.path}")
    $logger.error("PARAMS: #{params}\n\n")
    halt_with(404, env['sinatra.error'].message)
  end

  #
  # Captures all unhandled errors
  #
  error do
    $logger.error("Internal server error: #{env['sinatra.error']}")
    $logger.error("PATH: #{request.path}\r\nPARAMS: #{params}")
    halt_with(500, 'Internal server error.')
  end

  private

  #
  # Returns an error json, containing the http status reported.
  #
  def halt_with(status, message)
    halt status, { 'Content-Type' => 'application/json' },
                 { status: status, message: message }.to_json
  end

  #
  # Returns an error json, containing the http status reported.
  #
  def halt_data(status, data)
    halt status, { 'Content-Type' => 'application/json' }, data.to_json
  end
end
