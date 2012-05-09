ENV["RACK_ENV"] ||= "test"

require "bundler"
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

require "SimpleCov"
SimpleCov.start

require File.expand_path(File.dirname(__FILE__) + "/../loot.rb")

Webrat.configure do |conf|
  conf.mode = :rack
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Webrat::Methods
  conf.include Webrat::Matchers
end