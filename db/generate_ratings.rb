require_relative '../config/environment'

ratings = []
shows = JSON.parse(File.read('db/json/shows.json'))
viewers = JSON.parse(File.read('db/json/viewers.json'))

while ratings.size < 300
  ratings << {
    show: shows.sample,
    viewer: viewers.sample
  }
  ratings.uniq! ## Ensure no duplicates
end

ratings.each { |r| r[:rating] = rand(1..5) }

File.open("db/json/ratings.json", "w") { |f| f.write ratings.to_json }

# binding.pry
