class QuotePriceJobService
  def update_quotes
    Asset.all.each do |asset|
      UpdateQuotePriceJob.perform_async(asset.symbol)
    end
  end
end
