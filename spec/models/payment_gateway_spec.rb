require 'rails_helper'

RSpec.describe PaymentGateway, type: :model do
  let!(:debit_card) { create(:payment_type, name: 'NETS', payment_method: 'CARD_DEBIT') }
  let!(:credit_card) { create(:payment_type, name: 'VISA', payment_method: 'CARD_CREDIT') }

  let!(:receipt) { create(:receipt) }
  let!(:transaction) { create(:transaction, receipt: receipt) }

  let!(:payment_gateway) { PaymentGateway.new }

  describe '#pay' do
    context 'using braintree' do
      before { payment_gateway.adapter = :braintree }

      context 'transaction by debit card' do
        before { transaction.update(payment_type: debit_card) }

        it 'make the transaction fail' do
          payment_gateway.pay transaction
          expect(transaction.reload.status).to eq('failed')
        end
      end

      context 'transaction by credit card' do
        before { transaction.update(payment_type: credit_card) }

        it 'make the transaction success' do
          payment_gateway.pay transaction
          transaction.reload
          expect(transaction.status).to eq('successful')
          expect(transaction.payment_gateway).to eq('braintree')
        end
      end
    end

    context 'using wirecard' do
      before { payment_gateway.adapter = :wirecard }

      context 'transaction by credit card' do
        before { transaction.update(payment_type: credit_card) }

        it 'make the transaction fail' do
          payment_gateway.pay transaction
          expect(transaction.reload.status).to eq('failed')
        end
      end

      context 'transaction by debit card' do
        before { transaction.update(payment_type: debit_card) }

        it 'make the transaction success' do
          payment_gateway.pay transaction
          transaction.reload
          expect(transaction.status).to eq('successful')
          expect(transaction.payment_gateway).to eq('wirecard')
        end
      end
    end
  end
end
