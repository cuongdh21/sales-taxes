require 'csv'    

class Receipt < ApplicationRecord
  EXPORT_PATH = Rails.env.test? ? 'spec/fixtures' : 'tmp'

  def self.csv_processing csv_in_path, csv_out_name
    receipt = create_from_csv csv_in_path
    export_to_csv receipt, csv_out_name
  end

  def self.create_from_csv csv_path
    sale_taxes = 0
    total = 0
    products = []

    CSV.foreach(csv_path, headers: :first, return_headers: false) do |row|
      product = Product.where(name: row['Product']).first
      quantity = row['Quantity'].to_i
      unit_price = product.unit_price
      sales_tax = product.sales_tax_rate * unit_price
      total_price = product.total_price

      products << {
        product_id: product.id,
        quantity: quantity,
        unit_price: unit_price,
        sales_tax: sales_tax,
        total_price: total_price
      }

      sale_taxes += sales_tax * quantity
      total += total_price * quantity
    end

    create(details: { products: products, sale_taxes: sale_taxes.round(2), total: total.round(2) })
  end

  def self.export_to_csv receipt, csv_name
    receipt_details = receipt.details
    products = receipt_details['products']

    file_path = Rails.root.join(EXPORT_PATH, csv_name)
    CSV.open(file_path, 'wb') do |csv|
      products.each do |product|
        product_name = Product.find_by_id(product['product_id']).try(:name)

        csv << [product['quantity'], product_name, '%.2f' % product['total_price']]
      end

      sale_taxes = '%.2f' % receipt_details['sale_taxes']
      csv << ["Sales Taxes: #{sale_taxes}"]

      total = '%.2f' % receipt_details['total']
      csv << ["Total: #{total}"]
    end
  end

  def self.export_path
    EXPORT_PATH
  end
end
