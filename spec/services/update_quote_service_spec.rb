require 'rails_helper'

RSpec.describe UpdateQuoteService, type: :service do
  let!(:asset) { Asset.create!(symbol: 'PETZ3', currency: 'BRL') }
  let!(:quote) { Quote.create!(price: 1860.0, current: true, asset_id: asset.id) }

  describe 'update all quotes' do
    describe 'when creating a new quote' do
      context 'invoking the service' do
        it 'creates a new quote', :vcr do
          new_quote = VCR.use_cassette('petz3') { UpdateQuoteService.new(asset.symbol).update_quote }
          expect(asset.last_quote).to eq(new_quote)
        end

        it 'updates current quotes to false', :vcr do
          new_quote = VCR.use_cassette('petz3') { UpdateQuoteService.new(asset.symbol).update_quote }
          quote.reload
          expect(quote.current).to eq(false)
        end

        it 'sets new quote to current', :vcr do 
          new_quote = VCR.use_cassette('petz3') { UpdateQuoteService.new(asset.symbol).update_quote }
          expect(new_quote.current).to eq(true)
        end

        it 'creates a new quote with updated price', :vcr do
          new_quote = VCR.use_cassette('petz3') { UpdateQuoteService.new(asset.symbol).update_quote }
          expect(new_quote.price).to eq(1772.0)
        end
      end
    end
  end
end
