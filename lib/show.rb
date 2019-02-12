class Show < ActiveRecord::Base
  has_many :ratings
  has_many :viewers, through: :ratings

  def average_rating
    (ratings.sum(:rating).to_f / num_ratings).round(1)
  end

  def num_ratings
    ratings.count
  end

  def self.highest_average_rating
    Show.all.max_by { |show| show.average_rating }
  end
end
