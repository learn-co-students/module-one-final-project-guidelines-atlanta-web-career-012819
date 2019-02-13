require_relative '../config/environment'

Show.destroy_all
Viewer.destroy_all
Rating.destroy_all

shows = JSON.parse(File.read('db/json/shows.json'))
viewers = JSON.parse(File.read('db/json/viewers.json'))
ratings = JSON.parse(File.read('db/json/ratings.json'))

# 10.times do
#   ## TODO: Move th is to another file and refactor using a while loop
#   show_data = JSON.parse(RestClient.get("http://api.tvmaze.com/shows/#{rand(1..10000)}"))

#   # Show.create(title: show_data["name"], network: show_data["network"]["name"],
#   #   country: show_data["network"]["country"]["name"], summary: show_data["summary"])
#   Show.create(title: show_data["name"], network: show_data["network"]["name"],
#     country: show_data["network"]["country"]["name"])
#   end

shows.each { |s| Show.create title: s["title"], network: s["network"], country: s["country"] }
viewers.each { |v| Viewer.create name: v["name"], country: v["country"] }

ratings.each do |r|
  # binding.pry
  Rating.create(rating: r["rating"], show: Show.find_by(title: r["show"]["title"]),
    viewer: Viewer.find_by(name: r["viewer"]["name"]))
end

# 50.times do
#   Viewer.create(name: Faker::Name.unique.name, country: Show.countries.sample)
# end

# 300.times do
#   ## TODO: Refactor this and look for uniqueness
#   show = Show.all.sample
#   viewer = Viewer.all.sample
#   Rating.create(rating: rand(1..5), show: show, viewer: viewer)
# end
# binding.pry
