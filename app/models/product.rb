class Product < ApplicationRecord
  include Concerns::Taxable

  TAX_EXEMPTED_PRODUCTS = ['book', 'chocolate', 'pills']

  def sales_tax
    (unit_price * sales_tax_rate).round(2)
  end

  def total_price
    (unit_price + sales_tax).round(2)
  end

  def self.import_from_csv csv_file
  	CSV.foreach(csv_file, headers: :first, return_headers: false) do |row|
      name = row['Product']
      type = name.include?('import') ? 'ImportedProduct' : 'DosmeticProduct'
      tax_exempted = name.match(Regexp.union(TAX_EXEMPTED_PRODUCTS)).present?
      unit_price = row['Price'].to_f/row['Quantity'].to_i

      create(name: name, unit_price: unit_price, type: type, tax_exempted: tax_exempted)
  	end
  end
end
