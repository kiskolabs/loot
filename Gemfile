source "https://rubygems.org"

gem "sinatra", "~> 1.3.2"
gem "foreman"
gem "thin"
gem "flowdock"
gem "i18n"
gem "airbrake", require: false
gem "linguistics", "~> 1.0.9"
gem "twitter_cldr", "~> 1.1.0"

group :development do
  gem "heroku", ">= 2.23.0"
  gem "shotgun"
end

group :test do
  gem "rspec", "~> 2.10.0"
  gem "rack-test", require: "rack/test"
  gem "webrat"
  gem "simplecov", require: false
end

group :development, :test do
  gem "rake"
end