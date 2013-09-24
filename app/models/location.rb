class Location < ActiveRecord::Base
  attr_accessible :addressline1, :addressline2, :addressline3, :addressline4, :city, :state_id, :country_id, :postal, 
  :contactlocations_attributes, :clientlocations_attributes, :contacts_attributes, :clients_attributes, 
  :addresstypes_attributes, :divisions_attributes

  has_many :clientlocations, :dependent => :delete_all
  has_many :contactlocations, :dependent => :delete_all
  has_many :clients, through: :clientlocations
  has_many :addresstypes, through: :clientlocations
  has_many :contacts, through: :contactlocations
  has_many :divisions
  belongs_to :state
  belongs_to :country
  
  accepts_nested_attributes_for :state
  accepts_nested_attributes_for :country
  accepts_nested_attributes_for :clients
  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :clientlocations
  accepts_nested_attributes_for :contactlocations
  accepts_nested_attributes_for :addresstypes
  accepts_nested_attributes_for :divisions

end
