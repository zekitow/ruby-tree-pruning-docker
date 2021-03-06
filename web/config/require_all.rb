# frozen_string_literal: true

Dir.glob('./lib/**/**/*.rb').each { |file| load file }
Dir.glob('./app/{helpers}/**/*.rb').each { |file| load file }
Dir.glob('./app/exceptions/*.rb').each { |file| load file }
Dir.glob('./app/controllers/application_controller.rb').each { |file| load file }
Dir.glob('./app/requests/base_*.rb').each { |file| load file }
Dir.glob('./app/models/base_*.rb').each { |file| load file }
Dir.glob('./app/services/base_service.rb').each { |file| load file }
Dir.glob('./app/{requests,controllers,models,services}/**/**/*.rb').each { |file| load file }
