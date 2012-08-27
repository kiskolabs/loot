# encoding: UTF-8
module Loot
  module Helpers
    Linguistics::use( :en )
    include Linguistics::EN
    alias pluralize no

    def tags
      if ENV["TAGS"]
        ENV["TAGS"].to_s.split(",")
      else
        ["amiando"]
      end
    end

    def subject(tickets, value, currency = "EUR")
      "Ticket #{plural('sale', tickets.to_i)}! (#{format_money(value, currency)})"
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
      replace_invalid_unicode_characters(html)
    end

    def build_content(params)
      tickets = params[:numberOfTickets].to_i
      value = params[:paymentValue]
      currency = params[:paymentCurrency]
      <<-EOS
        <p>
          Sold #{pluralize('ticket', tickets)} for
          #{format_money(value, currency)}.
        </p>
        #{formatted_ticket_list(params)}
      EOS
    end

    def format_money(value, currency = "EUR")
      value = value.to_i / 100
      symbol = if TwitterCldr::Shared::Currencies.for_code(currency)
        TwitterCldr::Shared::Currencies.for_code(currency)[:symbol]
      else
        currency
      end

      "#{symbol}#{value}"
    end

    def replace_invalid_unicode_characters(value)
      value.encode("UTF-8", invalid: :replace, undef: :replace, replace: "?")
    end
  end
end
