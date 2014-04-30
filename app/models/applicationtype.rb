class Applicationtype < ActiveRecord::Base
  attr_accessible :name, :applications_attributes

  has_many :applications
  accepts_nested_attributes_for :applications

  scope :original, -> { 
    where(:name=>'original')
  }

end
