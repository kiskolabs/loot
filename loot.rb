# encoding: UTF-8
class Loot < Sinatra::Application
  get "/" do
    status 200
    content_type "text/plain"
    "OK"
  end

  post "/amiando/:secret" do
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

  def indefinite_articlerise(params_word)
    %w(a e i o u).include?(params_word[0].downcase) ? "an #{params_word}" : "a #{params_word}"
  end

  def pluralize(word, count = 1)
    count == 1 ? "one #{word}" : "#{count} #{word}s"
  end

  def subject(tickets = 1, paymentValue)
    value = paymentValue / 100
    if tickets == 1
      "Ticket sale! (€#{value})"
    else
      "Ticket sales! (€#{value})"
    end
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