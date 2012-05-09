# encoding: UTF-8

if ENV["AIRBRAKE"]
  require "airbrake"

  Airbrake.configure do |config|
    config.api_key = ENV["AIRBRAKE"]
  end
end

class Loot < Sinatra::Application
  Linguistics::use( :en )

  if ENV["AIRBRAKE"]
    use Airbrake::Rack
    enable :raise_errors
  end

  helpers do
    include Linguistics::EN
    alias pluralize no
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
        subject: subject(params[:numberOfTickets].to_i, params[:paymentValue]),
        content: build_content(params),
        tags: tags
      })
    else
      status 403
      "403 Forbidden"
    end
  end

  private

  def tags
    if ENV["TAGS"]
      ENV["TAGS"].to_s.split(",")
    else
      ["amiando"]
    end
  end

  def subject(tickets = 1, paymentValue)
    value = paymentValue.to_i / 100
    "Ticket #{plural('sale', tickets)}! (€#{value})"
  end

  def ticket_list_from_params(params)
    (0..(params[:numberOfTickets].to_i - 1)).map do |i|
      {
        first_name: params["ticketFirstName#{i}"],
        last_name: params["ticketLastName#{i}"],
        category: params["ticketCategory#{i}"]
      }
    end
  end

  def formatted_ticket_list(params)
    tickets = ticket_list_from_params(params)
    html = "<ul>"
    html << tickets.map do |ticket|
      "<li>#{ticket[:category]}: #{ticket[:first_name]} #{ticket[:last_name]}</li>"
    end.join
    html << "</ul>"
  end

  def build_content(params)
    html = "<p>Sold #{pluralize('ticket', params[:numberOfTickets].to_i)} for €#{params[:paymentValue].to_i / 100}.</p>"
    html << formatted_ticket_list(params)
  end
end