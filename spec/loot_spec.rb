require "spec_helper"

describe Loot do
  let(:app) { Loot }
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
      "secret" => "75857cffdb841b3d643071798589e996e2265b1c",
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

  describe "GET '/'" do
    it "should be successful" do
      get "/"
      last_response.should be_ok
    end
  end
end