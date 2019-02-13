require_relative '../config/environment'

# Show.destroy_all
Rating.destroy_all
Viewer.destroy_all

10.times do
  ## TODO: Move this to another file and refactor using a while loop
  show_data = JSON.parse(RestClient.get("http://api.tvmaze.com/shows/#{rand(1..10000)}"))

  # Show.create(title: show_data["name"], network: show_data["network"]["name"],
  #   country: show_data["network"]["country"]["name"], summary: show_data["summary"])
  Show.create(title: show_data["name"], network: show_data["network"]["name"],
    country: show_data["network"]["country"]["name"])
end

50.times do
  Viewer.create(name: Faker::Name.unique.name, country: Show.countries.sample)
end

300.times do
  ## TODO: Refactor this and look for uniqueness
  show = Show.all.sample
  viewer = Viewer.all.sample
  Rating.create(rating: rand(1..5), show: show, viewer: viewer)
end
