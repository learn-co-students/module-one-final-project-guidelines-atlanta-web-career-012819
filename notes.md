# TV Show Ratings - Data Analytics

## Models: Viewer < Rating > Show
### Viewer
* has_many :shows
### Review JOINS Viewer | Show
* belongs_to :user
* belongs_to :show
* @rating = rand(1..5)
### Show
* has_many :viewers
---
## API's
### TVMAZE
* http://www.tvmaze.com/api
---
## Data
### Viewers
* Generate 20 random names
  * Faker gem?
* `@name`
* `@country`
### Ratings
* Generate a random integer between 1 and 5 to represent the rating
  * `@rating = rand(1..5)`
### Shows
* Data generation: pull 10 random shows from a selection of 20,000
  * `arr = []`
  * `10.times { arr << JSON.parse(RestClient.get("http://api.tvmaze.com/shows/#{rand(1..20000)}")) }`
* `@title =` **show**`["name"]`
* `@network =`**show**`["network"]["name"]`
* `@country =` **show**`["network"]["country"]["name"]`
* `@summary =` **show**`["summary"]`
---
## User Stories
1. As a user, I want to be able to look at what `shows` a given `viewer` has rated
2. As a user, I want to be able to look at the average rating for a given `show`
3. As a user, I want to be able to find the show with the most `viewers`
4. As a user, I want to be able to find the `show` with the best `rating`
5. As a user, I want to find a `viewer`'s *top 3* favorite shows
---
# TODO
* Data pulled in through Rest-Client is never consistent; sometimes the request fails. Why?
* Come up with a way to create a standardized list of countries to pull country data from
  * Maybe use `Faker` instead of pulling this data from the JSON
* Sometimes a viewer will rate the same show multiple times. Create a way to ensure _uniqueness_
