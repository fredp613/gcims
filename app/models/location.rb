class Location < ActiveRecord::Base

  include PgSearch

  attr_accessible :addressline1, :addressline2, :addressline3, :addressline4, :city, :state_id, :country_id, :postal, 
  :contactlocation_attributes, :clientlocation_attributes, :contacts_attributes, :clients_attributes, 
  :addresstypes_attributes, :divisions_attributes, :client, :contact

  attr_accessor :client, :contact

  has_one :clientlocation, :dependent => :delete
  has_one :contactlocation, :dependent => :destroy
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
  accepts_nested_attributes_for :clientlocation
  accepts_nested_attributes_for :contactlocation
  accepts_nested_attributes_for :addresstypes
  accepts_nested_attributes_for :divisions


  validates :addressline1, presence: true

  pg_search_scope :search, against: [:addressline1, :addressline2, :addressline3, :addressline4, :city],
  using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}},
  associated_against: { state: :name }

  
  def self.text_search(query)
    if query.present?
      search(query)
    else
      where(nil)
    end
  end 

end
