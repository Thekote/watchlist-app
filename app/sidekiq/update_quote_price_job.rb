class UpdateQuotePriceJob
  include Sidekiq::Job
  sidekiq_options retry: 5

  def perform(asset)
    UpdateQuoteService.new(asset).update_quote
  end
end
