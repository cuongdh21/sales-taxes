class Product < ApplicationRecord
  include Concerns::Taxable

  def sales_tax
    amount = unit_price * sales_tax_rate
    Helpers::PriceHelper.round amount
  end

  def total_price
    unit_price + sales_tax
  end
end
