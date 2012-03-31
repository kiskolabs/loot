require "net/http"
require "net/https"

class Loot < Sinatra::Application
  FLOW_URI = URI.parse("https://api.flowdock.com/v1/messages/team_inbox/#{ENV['FLOW_API_TOKEN']}")

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

      request = Net::HTTP::Post.new(FLOW_URI.request_uri)
      request["User-Agent"] = "Loot"
      request.set_form_data({
        source: "Amiando",
        from_address: "amiando@frozenrails.eu",
        from_name: "Amiando",
        subject: "Ticket sales! (#{params[:paymentValue]})",
        content: "Sold #{pluralize('ticket', params[:numberOfTickets].to_i)} for #{params[:paymentValue]}.",
        tags: ["frozenrails", "amiando"]
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
end