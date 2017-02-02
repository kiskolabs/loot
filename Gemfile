source "https://rubygems.org"

gem "sinatra", "~> 1.3.3" # This change was made via Snyk to fix a vulnerability
gem "foreman"
gem "thin", "~> 1.4.1" # This change was made via Snyk to fix a vulnerability
gem "flowdock", "~> 0.2.1" # This change was made via Snyk to fix a vulnerability
gem "i18n", "~> 0.6.8" # This change was made via Snyk to fix a vulnerability
gem "airbrake", "~> 3.1.3", require: false # This change was made via Snyk to fix a vulnerability
gem "linguistics", "~> 1.0.9"
gem "twitter_cldr", "~> 1.1.0"

group :development do
  gem "shotgun", "~> 0.9" # This change was made via Snyk to fix a vulnerability
end

group :test do
  gem "rspec", "~> 2.10.0"
  gem "rack-test", require: "rack/test"
  gem "webrat", "~> 0.7.3" # This change was made via Snyk to fix a vulnerability
  gem "simplecov", require: false
end

group :development, :test do
  gem "rake"
end