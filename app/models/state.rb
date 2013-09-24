class State < ActiveRecord::Base
 attr_accessible :id, :iso, :name, :country_id

 has_many :locations
 belongs_to :country

 accepts_nested_attributes_for :country

 
end
