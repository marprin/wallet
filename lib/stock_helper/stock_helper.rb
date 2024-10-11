require 'uri'
require 'net/http'

module StockHelper
  class StockPrice
    def all_price
      url = URI.parse("#{RAPID_API_BASE_URL}/any")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true if url.scheme == 'https'

      request = Net::HTTP::Get.new(url, { 'Content-Type' => 'application/json' })
      request["x-rapidapi-key"] = RAPID_API_HOST
      request["x-rapidapi-host"] = RAPID_API_HOST

      http.request(request)
    end
  end
end
