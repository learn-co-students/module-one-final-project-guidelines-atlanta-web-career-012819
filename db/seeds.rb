require_relative '../config/environment'

Show.destroy_all
Rating.destroy_all
Viewer.destroy_all

10.times do
  show_data = JSON.parse(RestClient.get("http://api.tvmaze.com/shows/#{rand(1..10000)}"))

  Show.create(title: show_data["name"], network: show_data["network"]["name"],
    country: show_data["network"]["country"]["name"], summary: show_data["summary"])
end

50.times do
  Viewer.create(name: Faker::Name.unique.name, country: Faker::Address.country)
end

300.times do
  Rating.create(rating: rand(1..5), show: Show.all.sample, viewer: Viewer.all.sample)
end
