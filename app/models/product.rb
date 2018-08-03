class Product < ApplicationRecord
  include Concerns::Taxable

  TAX_EXEMPTED_SAMPLES = ['book', 'chocolate', 'pills'].freeze

  def sales_tax
    amount = unit_price * sales_tax_rate
    Helpers::PriceHelper.round amount
  end

  def total_price
    unit_price + sales_tax
  end

  def self.import_from_csv(csv_file)
    CSV.foreach(csv_file, headers: :first, return_headers: false) do |row|
      name = row['Product']
      type = name.include?('import') ? 'ImportedProduct' : 'DosmeticProduct'
      tax_exempted = name.match(Regexp.union(TAX_EXEMPTED_SAMPLES)).present?
      unit_price = row['Price'].to_f / row['Quantity'].to_i
      create(name: name, unit_price: unit_price, type: type, tax_exempted: tax_exempted)
    end
  end
end
