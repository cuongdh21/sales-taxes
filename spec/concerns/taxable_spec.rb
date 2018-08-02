require 'rails_helper'

RSpec.describe Concerns::Taxable do
  before do
    class TaxableTestClass
      include ActiveModel::Model
      include Concerns::Taxable

      attr_accessor :id, :unit_price, :tax_exempted, :type
    end
  end

  describe '#basic_tax_rate' do
    context 'on tax exemped product' do
      let(:exemped_product) { TaxableTestClass.new(tax_exempted: true) }

      it 'should be 0' do
        expect(exemped_product.basic_tax_rate).to eq(0)
      end
    end

    context 'on non-tax-exemped product' do
      let(:non_exemped_product) { TaxableTestClass.new(tax_exempted: false) }

      it 'should be 0.1' do
        expect(non_exemped_product.basic_tax_rate).to eq(0.1)
      end
    end
  end

  describe '#import_tax_rate' do
    context 'on imported product' do
      let(:imported_product) { TaxableTestClass.new(type: 'ImportedProduct') }

      it 'should be 0.05' do
        expect(imported_product.import_tax_rate).to eq(0.05)
      end
    end

    context 'on dosmetic product' do
      let(:dosmetic_product) { TaxableTestClass.new(type: 'DosmeticProduct') }

      it 'should be 0' do
        expect(dosmetic_product.import_tax_rate).to eq(0)
      end
    end
  end
end
