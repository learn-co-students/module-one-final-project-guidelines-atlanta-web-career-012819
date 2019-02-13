require_relative '../config/environment'

viewers = []
countries = JSON.parse(File.read('db/json/countries.json'))

50.times do
  viewers << {
      name: Faker::Name.unique.name,
      country: countries.sample
    }
end

File.open("db/json/viewers.json", "w") { |f| f.write viewers.to_json }

# binding.pry
