module GatewayAdapters
  module Wirecard
    def self.pay(transaction)
      transaction.payment_type.payment_method == 'CARD_DEBIT' ? transaction.success(:wirecard) : transaction.fail
    end
  end
end
