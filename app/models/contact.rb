class Contact < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :title, :contacttype_id, :authority, :locations_attributes,
  :contactlocations_attributes, :client_id,:custom_field, :salutation

  belongs_to :client
  
  has_many :projectcontacts	
  has_many :projects, through: :projectcontacts
  has_many :contactlocations,:dependent => :destroy
  has_many :locations, through: :contactlocations
  has_many :emails
  has_many :phones
  has_one :contacttype

  accepts_nested_attributes_for :locations
  accepts_nested_attributes_for :contactlocations
  accepts_nested_attributes_for :phones
  accepts_nested_attributes_for :emails

  def fullname
    firstname + " " + lastname
  end

end
