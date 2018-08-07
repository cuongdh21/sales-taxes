class PaymentGateway
  module Adapters
    module Braintree
      def self.pay(transaction)
        transaction.payment_type.payment_method == 'CARD_CREDIT' ? transaction.success(:braintree) : transaction.fail
      end
    end

    module Wirecard
      def self.pay(transaction)
        transaction.payment_type.payment_method == 'CARD_DEBIT' ? transaction.success(:wirecard) : transaction.fail
      end
    end
  end

  def adapter
    return @adapter if @adapter
    self.adapter = :braintree
    @adapter
  end

  def adapter=(adapter)
    @adapter = Adapters.const_get(adapter.to_s.capitalize)
  end

  def pay(transaction)
    adapter.pay transaction
  end
end
