require 'rails_helper'

RSpec.describe QuotePriceJobService, type: :service do
  describe '#update_quotes' do
    let!(:asset) { Asset.create!(symbol: 'PETZ3', currency: 'BRL') }

    it 'invokes the job' do
      expect(UpdateQuotePriceJob).to receive(:perform_async)
      .with(asset.symbol)
      .and_call_original

      QuotePriceJobService.new.update_quotes
      
      expect(UpdateQuotePriceJob).to have_enqueued_sidekiq_job(asset.symbol)
    end
  end  
end
