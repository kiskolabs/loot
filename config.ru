require "bundler"
Bundler.require

require File.expand_path("../loot.rb", __FILE__)

$stdout.sync = true

run Loot