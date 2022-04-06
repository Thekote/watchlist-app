class GetSharePriceService
  CONVERSION_TO_INT = 100

  def initialize(asset)
    @asset = asset
  end

  def share_price
    parsed_uri = URI.parse("https://statusinvest.com.br/acoes/#{@asset.downcase}")
    response = Net::HTTP.get_response(parsed_uri)
    raise BadUrlError if response.code == '404'
    html_body = Nokogiri::HTML(response.body)
    html_body.css("strong").first.text.gsub(",", ".").to_f*CONVERSION_TO_INT    
  end
end
