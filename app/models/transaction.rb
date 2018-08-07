class Transaction < ApplicationRecord
  belongs_to :payment_type
  belongs_to :receipt

  def success(payment_gateway = nil)
    return if status == 'successful'
    update(status: :successful, payment_gateway: payment_gateway)
  end

  def fail
    return if status == 'failed'
    update(status: :failed)
  end
end
