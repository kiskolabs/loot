require "bundler"
Bundler.require

require File.expand_path("../lib/loot.rb", __FILE__)

$stdout.sync = true

run Loot::Application