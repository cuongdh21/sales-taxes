class Transaction < ApplicationRecord
  belongs_to :payment_type
  belongs_to :receipt

  def success payment_gateway
    update(status: :successful, payment_gateway: payment_gateway)
  end

  def fail
    update(status: :failed)
  end
end
