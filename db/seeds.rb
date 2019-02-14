require_relative '../config/environment'

Show.destroy_all
Viewer.destroy_all
Rating.destroy_all

shows = JSON.parse(File.read('db/json/shows.json'))
viewers = JSON.parse(File.read('db/json/viewers.json'))
ratings = JSON.parse(File.read('db/json/ratings.json'))

shows.each { |s| Show.create title: s["title"], network: s["network"], country: s["country"],
  summary: s["summary"].empty? ? "No summary available." : s["summary"] }
viewers.each { |v| Viewer.create name: v["name"], country: v["country"] }

ratings.each do |r|
  # binding.pry
  Rating.create(rating: r["rating"], show: Show.find_by(title: r["show"]["title"]),
    viewer: Viewer.find_by(name: r["viewer"]["name"]))
end
