require_relative '../config/environment'

shows = []

while shows.size < 10
  begin
    data = JSON.parse(RestClient.get("http://api.tvmaze.com/shows/#{rand(1..10000)}"))
    shows << {
      title: data["name"],
      network: data["network"]["name"],
      country: data["network"]["country"]["name"]
    }
    puts "SUCCESS"
  rescue RestClient::ExceptionWithResponse => e
    puts "ERROR: #{e.response}"
  rescue StandardError => e
    puts "ERROR: NO DATA"
  end
end

countries = shows.collect { |s| s[:country] }.compact.uniq

File.open("db/json/shows.json", "w") { |f| f.write shows.to_json }
File.open("db/json/countries.json", "w") { |f| f.write countries.to_json }

# binding.pry
