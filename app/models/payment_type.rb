class PaymentType < ApplicationRecord
  has_many :transactions
end
