# TV Show Ratings - Data Analytics
## Setup
First, run `bundle install` from the root directory to install dependencies. Next run `rake db:migrate` to setup the database tables.

Random data has been generated already and stored for you as JSON in the `db/json` directory. If you would just like to get up and running quickly, simply run `rake db:seed` to seed the database with the supplied data.

Alternatively, you can run `rake generate:all` to generate a new set of random data, and then `rake db:seed` to seed the database.
## Getting Started
* Run `ruby bin/run.rb` to start the program.
* From the main menu, type `help` to list all of the available commands. From the main menu you can get a list of shows and a list of viewers. You can go to the `show` menu to get more data about each show, or go to the `viewer` menu to get more data about each viewer.
---
## Models: Viewer < Rating > Show
### Viewer
* has_many :shows
### Review
* belongs_to :user
* belongs_to :show
### Show
* has_many :viewers
## Data
### Viewers
* `@name` : full name of the viewer
* `@country` : country where the viewer resides
### Ratings
* `@rating` : represented as a random integer between 1 and 5
### Shows
* `@title` : title of the show
* `@network` : network the show airs on
* `@country` : country in which the show airs
* `@summary` : summary of the show
## User Stories
1. As a user, I want to be able to look at what `shows` a given `viewer` has rated.
2. As a user, I want to be able to look at the average rating for a given `show`.
3. As a user, I want to find a `viewer`'s *top 3* favorite shows.
3. As a user, I want to be able to see a list of `viewers` for any given show.
---
## API's
### TVMAZE
* http://www.tvmaze.com/api
---
# TODO
* Clean up the way in which data is pulled using Rest-Client, using the proper checking and error handling
* FIXME: The `@summary` has a bunch of `HTML` tags thrown in which sucks. Is there a way to strip them out?
  *  Either get rid of the `@summary` attribute entirely or figure this out!!!
