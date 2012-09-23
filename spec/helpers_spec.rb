# encoding: UTF-8
require "spec_helper"

describe Loot do
  let(:helpers) {
    class Klass
      include Loot::Helpers
    end
    Klass.new
  }

  describe "#format_money" do
    it "formats 1000 euro cents as '€10'" do
      helpers.format_money(1000, "EUR").should == "€10"
    end

    it "formats 5000 USD cents as '$10'" do
      helpers.format_money(1000, "USD").should == "$10"
    end
  end

  describe "#ticket_list_from_params" do
    it "parses a sale of a single ticket correctly" do
      tickets = helpers.ticket_list_from_params(params_for_one_ticket)
      tickets.length.should == 1
      tickets.first.keys.length.should == 3
    end

    it "parses a sale of multiple tickets correctly" do
      tickets = helpers.ticket_list_from_params(params_for_two_tickets)
      tickets.length.should == 2
      tickets.each do |ticket|
        ticket.keys.length.should == 3
      end
    end

    it "parses data from Windows-1252" do
      tickets = helpers.ticket_list_from_params(params_with_windows_1252)
      tickets.first[:last_name].should == "Meikäläinen"
    end
  end
end
