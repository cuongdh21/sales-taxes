require 'rails_helper'

RSpec.describe ImportedProduct, type: :model do
  describe "#imported_tax_rate" do
    let!(:imported_product) { create(:imported_product) }

    it 'should be 0.05' do
      expect(imported_product.import_tax_rate).to eq(0.05)
    end
  end

  describe "#sales_tax" do
    let!(:imported_product) { create(:imported_product, unit_price: 10.33) }

    it 'should be 15% of unit price rounded up to 2 digits' do
      expect(imported_product.sales_tax).to eq(1.55)
    end
  end  
end
