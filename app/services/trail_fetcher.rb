require 'uri'
require 'net/http'

# Linter wants
class TrailFetcher
  def get
    fetch_places_with_text_search
  end

  private

  def fetch_places_with_text_search
    url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?query=mt%20sanitas%20Boulder&type=route'
    make_request(url)
  end

  def fetch_nearby_places
    url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=1500&type=route'
    make_request(url)
  end

  def make_request(url)
    url += "&key=#{Rails.application.credentials.dig(:gcp, :maps_api_key)}"
    url = URI(url)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    https.request(request)
  end
end
