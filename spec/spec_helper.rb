# encoding: UTF-8
ENV["RACK_ENV"] ||= "test"

require "bundler"
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

require "simplecov"
SimpleCov.start

require File.expand_path(File.dirname(__FILE__) + "/../lib/loot.rb")
require File.expand_path(File.dirname(__FILE__) + "/params_helpers.rb")

Webrat.configure do |conf|
  conf.mode = :rack
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Webrat::Methods
  conf.include Webrat::Matchers
  conf.include ParamsHelpers
end