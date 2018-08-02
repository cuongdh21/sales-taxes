require 'rails_helper'

RSpec.describe DosmeticProduct, type: :model do
  let!(:dosmetic_product) { create(:dosmetic_product) }

  describe '#import_tax_rate' do
    it 'should be 0' do
      expect(dosmetic_product.import_tax_rate).to eq(0)
    end
  end

  describe '#sales_tax' do
    let!(:dosmetic_product) { create(:dosmetic_product, unit_price: 15.25) }

    it 'should be 10% of unit price rounded up to 2 digits' do
      expect(dosmetic_product.sales_tax).to eq(1.53)
    end
  end
end
