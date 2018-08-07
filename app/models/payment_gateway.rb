class PaymentGateway
  include GatewayAdapters::Braintree
  include GatewayAdapters::Wirecard

  def adapter
    return @adapter if @adapter
    self.adapter = :braintree
    @adapter
  end

  def adapter=(adapter)
    @adapter = GatewayAdapters.const_get(adapter.to_s.capitalize)
  end

  def pay(transaction)
    adapter.pay transaction
  end
end
