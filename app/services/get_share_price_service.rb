class GetSharePriceService
  CONVERSION_TO_INT = 100

  def initialize(asset)
    @asset = asset
  end

  def share_price
    begin
      parsed_uri = URI.parse("https://statusinvest.com.br/acoes/#{@asset.downcase}")
      html_body = Nokogiri::HTML(Net::HTTP.get_response(parsed_uri).body)
      get_price = html_body.css("strong").first.text.gsub(",", ".").to_f*CONVERSION_TO_INT
    rescue StandardError
      'Url was not found'
    end
  end
end
