require_relative '../config/environment'

shows_data = []
viewers_data = []

while shows_data.size < 10
  ## TODO: Move this to another file and refactor using a while loop
  begin
    shows_data << JSON.parse(RestClient.get("http://api.tvmaze.com/shows/#{rand(1..10000)}"))
    puts "SUCCESS"
  rescue RestClient::ExceptionWithResponse => e
    puts "ERROR: #{e.response}"
  end
end

binding.pry
