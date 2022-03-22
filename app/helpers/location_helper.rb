module LocationHelper
  US_CITIES_URL = 'https://raw.githubusercontent.com/kelvins/US-Cities-Database/main/csv/us_cities.csv'.freeze
  API_ENDPOINT = 'https://nominatim.openstreetmap.org/reverse'.freeze

  def get_location(lat, lon)
    uri = URI(API_ENDPOINT)
    params = { lon: lon, lat: lat, format: 'json' }
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)

    JSON.parse(res.body)
  end

  def get_locations()
    uri = URI(US_CITIES_URL)

    res = Net::HTTP.get_response(uri)
    addresses = res.body
    write_coordinations(addresses)
  end

  private

  def write_coordinations(addresses)
    addresses.split("\r\n").each_with_index do |address, idx|
      next if idx == 0
      segments = address.split(",")
      puts segments.inspect
      lat = segments[-2]
      lon = segments[-1]
      location = get_location(lat, lon)
      puts location.inspect
      Location.create(
        lat: lat.to_f,
        lon: lon.to_f,
        road_number: location["address"]["housenumber"],
        road_name: location["address"]["road"]
      )
    end
  end
end
