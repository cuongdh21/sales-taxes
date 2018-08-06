module Csv
  class Exporter
    RECEIPTS_EXPORT_PATH = Rails.env.test? ? 'spec/fixtures' : 'tmp'

    def self.export_receipt(receipt, output_file_name)
      details = receipt.details
      items = details['items']
      output_file_path = Rails.root.join(RECEIPTS_EXPORT_PATH, output_file_name)

      CSV.open(output_file_path, 'wb') do |csv|
        items.each do |product|
          product_name = Product.find_by_id(product['product_id']).try(:name)
          csv << [product['quantity'], product_name, Helpers::PriceHelper.display(product['total_price'])]
        end

        sale_taxes = Helpers::PriceHelper.display details['sale_taxes']
        csv << ["Sales Taxes: #{sale_taxes}"]

        total = Helpers::PriceHelper.display details['total']
        csv << ["Total: #{total}"]
      end
    end

    def self.receipts_export_path
      RECEIPTS_EXPORT_PATH
    end
  end
end
