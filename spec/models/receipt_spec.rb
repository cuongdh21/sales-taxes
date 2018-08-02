require 'rails_helper'

RSpec.describe Receipt, type: :model do
  export_path = Receipt.export_path

  let(:csv_out_name) { 'output.csv' }
  let(:csv_out_path) { Rails.root.join(export_path, csv_out_name) }

  after { File.delete(csv_out_path) if File.exist?(csv_out_path) }

  describe ".csv_transform" do
    context 'input1' do
      let(:input1_path) { Rails.root.join(export_path, 'input1.csv') }
      let(:output1_path) { Rails.root.join(export_path, 'output1.csv') }

      before do
        Product.import_from_csv(input1_path)
      end

      it 'should return output1' do
        Receipt.csv_transform input1_path, csv_out_name

        actual_csv = CSV.read(csv_out_path)
        expected_csv = CSV.read(output1_path)
        expect(actual_csv).to eq(expected_csv)
      end
    end

    context 'input2' do
      let(:input2_path) { Rails.root.join(export_path, 'input2.csv') }
      let(:output2_path) { Rails.root.join(export_path, 'output2.csv') }

      before do
        Product.import_from_csv(input2_path)
      end

      it 'should return output1' do
        Receipt.csv_transform input2_path, csv_out_name

        actual_csv = CSV.read(csv_out_path)
        expected_csv = CSV.read(output2_path)
        expect(actual_csv).to eq(expected_csv)
      end
    end

    context 'input3' do
      let(:input3_path) { Rails.root.join(export_path, 'input3.csv') }
      let(:output3_path) { Rails.root.join(export_path, 'output3.csv') }

      before do
        Product.import_from_csv(input3_path)
      end

      it 'should return output1' do
        Receipt.csv_transform input3_path, csv_out_name

        actual_csv = CSV.read(csv_out_path)
        expected_csv = CSV.read(output3_path)
        expect(actual_csv).to eq(expected_csv)
      end
    end
  end  
end
