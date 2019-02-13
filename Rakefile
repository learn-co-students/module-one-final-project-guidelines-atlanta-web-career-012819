require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

namespace :generate do
  desc 'generate show data'
  task :shows do
    require_relative 'db/generate_shows.rb'
  end

  desc 'generate viewers data'
  task :viewers do
    require_relative 'db/generate_viewers.rb'
  end

  desc 'generate ratings data'
  task :ratings do
    require_relative 'db/generate_ratings.rb'
  end

  desc 'generate all data'
  task :all do
    require_relative 'db/generate_shows.rb'
    require_relative 'db/generate_viewers.rb'
    require_relative 'db/generate_ratings.rb'
  end
end
