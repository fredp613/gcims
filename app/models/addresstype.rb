class Addresstype < ActiveRecord::Base
  attr_accessible :name
  has_many :clientlocations
  has_many :contactlocations

end
