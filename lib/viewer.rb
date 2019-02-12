class Viewer < ActiveRecord::Base
  has_many :ratings
  has_many :shows, through: :ratings

  ## Get the top rated show for this viewer
  def favorite_show
    ratings.order(rating: :DESC).limit(1).collect(&:show)
  end

  ## Get top three rated shows for this viewer
  def top_three
    # ratings.order(rating: :DESC).limit(3).collect(&:show)
    ratings.order(rating: :DESC).limit(3)
  end
end
