module GatewayAdapters
  module Braintree
    def self.pay(transaction)
      transaction.payment_type.payment_method == 'CARD_CREDIT' ? transaction.success(:braintree) : transaction.fail
    end
  end
end
