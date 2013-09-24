class Country < ActiveRecord::Base
  attr_accessible :id, :iso, :name
  has_many :states
  has_many :locations, through: :states
  accepts_nested_attributes_for :states
end
