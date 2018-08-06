require 'rails_helper'

RSpec.describe Csv::Exporter, type: :model do
  receipts_export_path = Csv::Exporter.receipts_export_path

  let(:csv_out_name) { 'output.csv' }
  let(:csv_out_path) { Rails.root.join(receipts_export_path, csv_out_name) }

  after { File.delete(csv_out_path) if File.exist?(csv_out_path) }

  describe '.export_receipt' do
    context 'input1' do
      let(:input1_path) { Rails.root.join(receipts_export_path, 'input1.csv') }
      let(:output1_path) { Rails.root.join(receipts_export_path, 'output1.csv') }

      before do
        Csv::Importer.import_products(input1_path)
      end

      it 'should return output1' do
        receipt = Csv::Importer.import_receipt input1_path
        Csv::Exporter.export_receipt receipt, csv_out_name

        actual_csv = CSV.read(csv_out_path)
        expected_csv = CSV.read(output1_path)
        expect(actual_csv).to eq(expected_csv)
      end
    end

    context 'input2' do
      let(:input2_path) { Rails.root.join(receipts_export_path, 'input2.csv') }
      let(:output2_path) { Rails.root.join(receipts_export_path, 'output2.csv') }

      before do
        Csv::Importer.import_products(input2_path)
      end

      it 'should return output2' do
        receipt = Csv::Importer.import_receipt input2_path
        Csv::Exporter.export_receipt receipt, csv_out_name

        actual_csv = CSV.read(csv_out_path)
        expected_csv = CSV.read(output2_path)
        expect(actual_csv).to eq(expected_csv)
      end
    end

    context 'input3' do
      let(:input3_path) { Rails.root.join(receipts_export_path, 'input3.csv') }
      let(:output3_path) { Rails.root.join(receipts_export_path, 'output3.csv') }

      before do
        Csv::Importer.import_products(input3_path)
      end

      it 'should return output3' do
        receipt = Csv::Importer.import_receipt input3_path
        Csv::Exporter.export_receipt receipt, csv_out_name

        actual_csv = CSV.read(csv_out_path)
        expected_csv = CSV.read(output3_path)
        expect(actual_csv).to eq(expected_csv)
      end
    end
  end
end
