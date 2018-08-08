module Csv
  class Importer
    TAX_EXEMPTED_SAMPLES = ['book', 'chocolate', 'pills'].freeze

    def self.import_products(file_path)
      CSV.foreach(file_path, headers: :first, return_headers: false) do |row|
        name = row['Product']
        type = name.include?('import') ? 'ImportedProduct' : 'DosmeticProduct'
        tax_exempted = name.match(Regexp.union(TAX_EXEMPTED_SAMPLES)).present?
        unit_price = row['Price'].to_f / row['Quantity'].to_i
        Product.create(name: name, unit_price: unit_price, type: type, tax_exempted: tax_exempted)
      end
    end

    def self.import_receipt(file_path)
      receipt_detail = { items: [], sale_taxes: 0, total: 0 }

      CSV.foreach(file_path, headers: :first, return_headers: false) do |row|
        product = Product.where(name: row['Product']).first
        quantity = row['Quantity'].to_i
        unit_price = product.unit_price
        sales_tax = product.sales_tax
        total_price = product.total_price

        receipt_detail[:items] << {
          product_id: product.id,
          quantity: quantity,
          unit_price: unit_price,
          sales_tax: sales_tax,
          total_price: total_price
        }

        receipt_detail[:sale_taxes] += sales_tax * quantity
        receipt_detail[:total] += total_price * quantity
      end

      Receipt.create(details: receipt_detail)
    end
  end
end
