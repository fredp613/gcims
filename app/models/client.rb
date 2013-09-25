class Client < ActiveRecord::Base
  include PgSearch

  attr_accessible :name, :name1, :salutation, :locations_attributes, :clientlocations_attributes, :clienttype_id, 
                  :websites_attributes, :phones_attributes, :emails_attributes, :incorporated, :registeredcharity, 
                  :registeredband, :mandate, :corporation_attributes, :charity_attributes, :band_attributes,
                  :divisions_attributes, :projects_attributes, :token
  attr_writer :current_step, :ts

  has_many :clientlocations, dependent: :delete_all
  has_many :locations, through: :clientlocations
  has_many :states, through: :locations 
  has_many :projects
  has_many :contacts, dependent: :delete_all
  has_many :emails
  has_many :phones
  has_many :websites
  has_many :divisions
  has_one :charity, dependent: :destroy
  has_one :band, dependent: :destroy
  has_one :corporation, dependent: :destroy
  has_many :applications, through: :projects
  has_many :commitmentitems, through: :applications
  has_many :summarycommitments, through: :commitmentitems
  has_many :subservicelines, through: :summarycommitments
  has_many :productservicelines, through: :subservicelines



  belongs_to :clienttype
  
  accepts_nested_attributes_for :locations
  accepts_nested_attributes_for :clientlocations
  accepts_nested_attributes_for :clienttype
  accepts_nested_attributes_for :websites
  accepts_nested_attributes_for :phones
  accepts_nested_attributes_for :emails
  accepts_nested_attributes_for :charity
  accepts_nested_attributes_for :band
  accepts_nested_attributes_for :corporation
  accepts_nested_attributes_for :divisions
  accepts_nested_attributes_for :projects

  pg_search_scope :search, against: [:name, :name1],
  using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}},
  associated_against: {projects: [:projectname, :projectdesc], applications: :corporate_file_number,
  commitmentitems: :ci_name, summarycommitments: :sc_name, subservicelines: :ssl_name, productservicelines: :psl_name,
  locations: [:addressline1, :addressline2, :city, :postal], states: :name, contacts: [:firstname, :lastname] }

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end 


  def adj_name
  	"#{salutation} #{name} #{name1}"
  end

  def current_step
    @current_step || steps.first
  end

  def steps
   
    @client = self.id
    @corp = Corporation.where(:client_id=>@client)
    @band = Band.where(:client_id=>@client)
    @charity = Charity.where(:client_id=>@client)

    @corp_select = Client.where(:id=>@client, :incorporated=>true)
    @band_select = Client.where(:id=>@client, :registeredband=>true)
    @charity_select = Client.where(:id=>@client, :registeredcharity=>true)

    steps = Array.new

    if !@corp_select.blank?
    steps.push 'corporation'
    end

    if !@band_select.blank?
    steps.push 'band'
    end

    if !@charity_select.blank?
    steps.push 'charity'
    end 

    

    return steps

  end

  
  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
     self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
  current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  
end
