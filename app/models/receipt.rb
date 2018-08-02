require 'csv'

class Receipt < ApplicationRecord
  EXPORT_PATH = Rails.env.test? ? 'spec/fixtures' : 'tmp'

  def self.csv_transform(input_file_path, output_file_name)
    receipt = create_from_csv input_file_path
    export_to_csv receipt, output_file_name
  end

  def self.create_from_csv(csv_path)
    sale_taxes = 0
    total = 0
    items = []

    CSV.foreach(csv_path, headers: :first, return_headers: false) do |row|
      product = Product.where(name: row['Product']).first
      quantity = row['Quantity'].to_i
      unit_price = product.unit_price
      sales_tax = product.sales_tax
      total_price = product.total_price

      items << {
        product_id: product.id,
        quantity: quantity,
        unit_price: unit_price,
        sales_tax: sales_tax,
        total_price: total_price
      }

      sale_taxes += sales_tax * quantity
      total += total_price * quantity
    end

    create(details: { items: items, sale_taxes: sale_taxes, total: total })
  end

  def self.export_to_csv(receipt, output_file_name)
    receipt_details = receipt.details
    items = receipt_details['items']
    output_file_path = Rails.root.join(EXPORT_PATH, output_file_name)

    CSV.open(output_file_path, 'wb') do |csv|
      items.each do |product|
        product_name = Product.find_by_id(product['product_id']).try(:name)
        csv << [product['quantity'], product_name, Helpers::PriceHelper.display(product['total_price'])]
      end

      sale_taxes = Helpers::PriceHelper.display receipt_details['sale_taxes']
      csv << ["Sales Taxes: #{sale_taxes}"]

      total = Helpers::PriceHelper.display receipt_details['total']
      csv << ["Total: #{total}"]
    end
  end

  def self.export_path
    EXPORT_PATH
  end
end
