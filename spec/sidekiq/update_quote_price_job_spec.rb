require 'rails_helper'

Sidekiq::Testing.fake!

RSpec.describe UpdateQuotePriceJob, type: :job do
  let!(:asset) { Asset.create!(symbol: 'PETZ3', currency: 'BRL') }

  describe '#perform_async' do
    it { is_expected.to be_retryable 5 }
    
    it 'queues a job' do
      UpdateQuotePriceJob.perform_async(asset.symbol)

      expect(UpdateQuotePriceJob).to have_enqueued_sidekiq_job(asset.symbol)
    end
  end
end
