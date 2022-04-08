class UpdateQuoteService
  
  def initialize(asset)
    @asset = asset
  end

  def update_quote
    price = GetSharePriceService.new(@asset).share_price
    selected_asset = Asset.find_by!(symbol: @asset)
    Quote.where(asset_id: selected_asset.id).update_all(current: false)
    Quote.create!(price: price, current: true, asset_id: selected_asset.id)
  end

end
