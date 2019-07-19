class Show < ActiveRecord::Base
  has_many :ratings
  has_many :viewers, through: :ratings

  ## Average rating for this show from all viewers
  def average_rating
    (ratings.sum(:rating).to_f / num_ratings).round(1)
  end

  ## Number of ratings for this show
  def num_ratings
    ratings.count
  end

  ## Return the show with the highest average rating
  def self.highest_average_rating
    Show.all.max_by { |show| show.average_rating }
  end

  ## Return the show with the most number of viewers
  def self.most_viewers
    Show.all.max_by { |show| show.viewers.count }
  end

  ## Return a unique list of countries shows are in
  def self.countries
    Show.select(:country).distinct.collect(&:country)
  end

end
