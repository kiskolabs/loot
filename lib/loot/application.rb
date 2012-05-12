require File.expand_path(File.dirname(__FILE__) + "/helpers.rb")

if ENV["AIRBRAKE"]
  require "airbrake"

  Airbrake.configure do |config|
    config.api_key = ENV["AIRBRAKE"]
  end
end

module Loot
  class Application < Sinatra::Application
    if ENV["AIRBRAKE"]
      use Airbrake::Rack
      enable :raise_errors
    end

    helpers do
      include Loot::Helpers
    end

    get "/" do
      status 200
      content_type "text/plain"
      "OK"
    end

    post "/amiando/:secret" do
      puts params.inspect if ENV["LOG_PARAMS"]

      content_type "text/plain"

      if params[:secret] == ENV["SECRET"]
        status 200

        # Create a new Flow object
        flow = Flowdock::Flow.new({
          api_token: ENV["FLOW_API_TOKEN"],
          source: ENV["SOURCE"],
          from: {
            name: ENV["FROM_NAME"],
            address: ENV["FROM_ADDRESS"]
          }
        })

        # Send a message to the Team Inbox
        flow.push_to_team_inbox({
          subject: subject(params[:numberOfTickets].to_i, params[:paymentValue], params[:paymentCurrency]),
          content: build_content(params),
          tags: tags
        })
      else
        status 403
        "403 Forbidden"
      end
    end
  end
end