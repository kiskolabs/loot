source "https://rubygems.org"

gem "sinatra", "~> 1.3.2"
gem "foreman"
gem "thin"
gem "flowdock"
gem "i18n"
gem "airbrake", require: false

group :development do
  gem "heroku", ">= 2.23.0"
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