# frozen_string_literal: true

require 'rack/test'
require 'rspec'
require 'simplecov'
require 'ruby-prof'
require 'vcr'
require './spec/support/json_helper'

SimpleCov.start

ENV['RACK_ENV'] = 'test'
require './app.rb'

def app
  App.new
end

module RSpecMixin
  include Rack::Test::Methods
end

RSpec.configure do |config|
  config.include RSpecMixin
  config.color = true
  config.tty   = true
  config.formatter = :documentation
end

VCR.configure do |c|
    c.cassette_library_dir = 'spec/cassettes'
    c.hook_into :webmock
    c.configure_rspec_metadata!
end

def start_profiling
  RubyProf.start
end

def end_profiling
  printer = RubyProf::MultiPrinter.new(RubyProf.stop)
  printer.print(path: '.', profile: 'profile')
end
