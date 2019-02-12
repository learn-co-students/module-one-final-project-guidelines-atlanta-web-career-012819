class Rating < ActiveRecord::Base
  belongs_to :show
  belongs_to :viewer
end
