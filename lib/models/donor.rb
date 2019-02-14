class Donor < ActiveRecord::Base
  has_many :donations
  has_many :causes, through: :donations



end
