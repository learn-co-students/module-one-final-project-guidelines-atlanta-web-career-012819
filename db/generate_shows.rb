require_relative '../config/environment'

shows = []

while shows.size < 100
  begin
    data = JSON.parse(RestClient.get("http://api.tvmaze.com/shows/#{rand(1..10000)}"))

    if data["name"] && data["network"] && data["summary"]
      if data["network"]["country"] && !data["summary"].empty?
        shows << {
          title: data["name"],
          network: data["network"]["name"],
          country: data["network"]["country"]["name"],
          summary: data["summary"].gsub(%r{</?[^>]+?>}, '')
        }
        shows.uniq!
        puts "SUCCESS"
      else
        puts "ERROR: EMPTY DATA"
        # binding.pry
      end
    else
      puts "ERROR: INVALID DATA"
      # binding.pry
    end
  rescue RestClient::ExceptionWithResponse => e
    err = JSON.parse(e.response)
    puts "ERROR: #{err["status"]} #{err["name"]}"
  end
end

countries = shows.collect { |s| s[:country] }.compact.uniq

File.open("db/json/shows.json", "w") { |f| f.write shows.to_json }
File.open("db/json/countries.json", "w") { |f| f.write countries.to_json }

# binding.pry
