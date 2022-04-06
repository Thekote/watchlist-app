require 'rails_helper'

RSpec.describe GetSharePriceService, type: :service do
  let(:share) { 'petz3' }
  let(:invalid_share) { 'invalid' }

  describe 'get share price' do
    context 'when invoking the service' do
      context 'with valid params' do
        it 'returns share price', :vcr do
          price = VCR.use_cassette('petz3') { GetSharePriceService.new(share).share_price }
          expect(price).to eq(1772.0)
        end
      end

      context 'with invalid params' do
        it 'return an error', :vcr do
          VCR.use_cassette('invalid_url') do
            expect { GetSharePriceService.new(invalid_share).share_price }.to raise_error(StandardError)          
          end
        end
      end
    end
  end
end
