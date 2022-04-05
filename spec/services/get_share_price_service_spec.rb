require 'rails_helper'

RSpec.describe GetSharePriceService, type: :service do
  let(:share) { 'petz3' }
  let(:invalid_share) { 'invalid' }

  describe 'get share price' do
    context 'when invoking the service' do
      it 'returns share price' do
        price = GetSharePriceService.new(share).share_price
        expect(price).to eq(1866.0)
      end

      it 'return an error 'do
        price = GetSharePriceService.new(invalid_share).share_price
        expect { price }.to rescue(StandardError)
      end
    end
  end
end
