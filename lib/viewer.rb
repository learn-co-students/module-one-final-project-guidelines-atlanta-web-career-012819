class Viewer < ActiveRecord::Base
  has_many :ratings
  has_many :shows, through: :ratings
end
