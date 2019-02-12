class Show < ActiveRecord::Base
  has_many :ratings
  has_many :viewers, through: :ratings
end
