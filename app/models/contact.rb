class Contact < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :title, :contacttype_id, :authority, :locations_attributes,
  :contactlocations_attributes, :projectcontact_attributes, :client_id,:custom_field, :salutation, :user_id, :type

  belongs_to :client
  belongs_to :user
  
  has_one :projectcontact, :dependent => :destroy
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
  accepts_nested_attributes_for :projectcontact

  def fullname
    firstname + " " + lastname
  end

end
