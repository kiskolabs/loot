# encoding: UTF-8
require "net/http"
require "net/https"

class Loot < Sinatra::Application
  FLOW_URI = URI.parse("https://api.flowdock.com/v1/messages/team_inbox/#{ENV['FLOW_API_TOKEN']}")
  SOURCE = ENV["SOURCE"]
  FROM_ADDRESS = ENV["FROM_ADDRESS"]
  FROM_NAME = ENV["FROM_NAME"]
  TAGS = ENV["TAGS"].to_s.split(",")

  get "/" do
    status 200
    content_type "text/plain"
    "OK"
  end

  post "/amiando/:secret" do
    content_type "text/plain"

    if params[:secret] == ENV["SECRET"]
      status 200

      http = Net::HTTP.new(FLOW_URI.host, FLOW_URI.port)

      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      paymentValue = params[:paymentValue].to_i / 100

      request = Net::HTTP::Post.new(FLOW_URI.request_uri)
      request["User-Agent"] = "Loot"
      request.set_form_data({
        source: SOURCE,
        from_address: FROM_ADDRESS,
        from_name: FROM_NAME,
        subject: subject(params[:numberOfTickets].to_i, paymentValue),
        content: "Sold #{pluralize('ticket', params[:numberOfTickets].to_i)} for €#{paymentValue}.",
        tags: TAGS
      })

      response = http.request(request)
      response.inspect
    else
      status 403
      "403 Forbidden"
    end
  end

  private

  def indefinite_articlerise(params_word)
    %w(a e i o u).include?(params_word[0].downcase) ? "an #{params_word}" : "a #{params_word}"
  end

  def pluralize(word, count = 1)
    count == 1 ? "one #{word}" : "#{count} #{word}s"
  end

  def subject(tickets = 1, value)
    if tickets == 1
      "Ticket sale! (€#{value})"
    else
      "Ticket sales! (€#{value})"
    end
  end
end