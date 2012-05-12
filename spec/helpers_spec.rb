# encoding: UTF-8
require "spec_helper"

describe Loot do
  let(:helpers) {
    class Klass
      include Loot::Helpers
    end
    Klass.new
  }
  let(:single_ticket_params) do
    {
      "eventId" => "56789012",
      "eventIdentifier" => "frozenrails-2012",
      "eventType" => "EVENT_TYPE_TICKETSHOP",
      "numberOfTickets" => "1",
      "paymentCurrency" => "EUR",
      "paymentFee" => "846",
      "paymentId" => "101234567",
      "paymentIdentifier" => "3RWSXYO00008",
      "paymentSalesTax" => "4656",
      "paymentShipmentFee" => "0",
      "paymentValue" => "24900",
      "paymentVipSupportFee" => "0",
      # "secret" => "secret_code",
      "ticketCategory0" => "Early Bird",
      "ticketCategoryId0" => "3518340",
      "ticketCategoryPrice0" => "24900",
      "ticketEmail0" => "john.doe@example.invalid",
      "ticketFirstName0" => "John",
      "ticketId" => "123456789",
      "ticketLastName0" => "Doe",
      "ticketNumber0" => "3151-0123-9876"
    }
  end

  describe "#format_money" do
    it "formats 1000 euro cents as '€10'" do
      helpers.format_money(1000, "EUR").should == "€10"
    end

    it "formats 5000 USD cents as '$10'" do
      helpers.format_money(1000, "USD").should == "$10"
    end
  end
end