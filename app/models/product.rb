class Product < ApplicationRecord
  include Concerns::Taxable

  def sales_tax
    (unit_price * sales_tax_rate).round(2)
  end

  def total_price
    (unit_price + sales_tax).round(2)
  end
end
