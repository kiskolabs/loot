# encoding: UTF-8
require "spec_helper"

describe Loot do
  let(:app) { Loot::Application }
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

  describe "GET '/'" do
    it "should be successful" do
      get "/"
      last_response.should be_ok
    end
  end

  describe "POST '/amiando/:secret'" do
    it "should be successful if the secret is correct" do
      ENV["SECRET"] = "secret"

      flow = double("flow")
      flow.should_receive(:push_to_team_inbox).and_return(true)
      Flowdock::Flow.stub(:new).and_return(flow)

      post "/amiando/secret", single_ticket_params
      last_response.should be_ok
    end

    it "should be unsuccessful if the secret is incorrect" do
      ENV["SECRET"] = "secret"
      post "/amiando/wrongsecret", single_ticket_params
      last_response.should be_forbidden
    end
  end
end