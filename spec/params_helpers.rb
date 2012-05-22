# encoding: UTF-8
module ParamsHelpers
  def params_for_one_ticket
    indifferent_hash({
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
      "ticketCategory0" => "Early Bird",
      "ticketCategoryId0" => "3518340",
      "ticketCategoryPrice0" => "24900",
      "ticketEmail0" => "john.doe@example.invalid",
      "ticketFirstName0" => "John",
      "ticketId" => "123456789",
      "ticketLastName0" => "Doe",
      "ticketNumber0" => "3151-0123-9876"
    })
  end

  def params_for_two_tickets
    indifferent_hash({
      "eventId" => "56789012",
      "eventIdentifier" => "frozenrails-2012",
      "eventType" => "EVENT_TYPE_TICKETSHOP",
      "numberOfTickets" => "2",
      "paymentCurrency" => "EUR",
      "paymentFee" => "846",
      "paymentId" => "101234567",
      "paymentIdentifier" => "3RWSXYO00008",
      "paymentSalesTax" => "4656",
      "paymentShipmentFee" => "0",
      "paymentValue" => "24900",
      "paymentVipSupportFee" => "0",
      "ticketCategory0" => "Early Bird",
      "ticketCategoryId0" => "3518340",
      "ticketCategoryPrice0" => "24900",
      "ticketEmail0" => "john.doe@example.invalid",
      "ticketFirstName0" => "John",
      "ticketId0" => "123456789",
      "ticketLastName0" => "Doe",
      "ticketNumber0" => "3151-0123-9876",
      "ticketCategory1" => "Early Bird",
      "ticketCategoryId1" => "3518340",
      "ticketCategoryPrice1" => "34900",
      "ticketEmail1" => "jane.doe@example.invalid",
      "ticketFirstName1" => "Jane",
      "ticketId1" => "234567890",
      "ticketLastName1" => "Doe",
      "ticketNumber1" => "3151-0123-0987"
    })
  end

  private

  def indifferent_hash(hash)
    indifferent = Hash.new { |h,k| h[k.to_s] if Symbol === k }
    indifferent.merge(hash)
  end
end