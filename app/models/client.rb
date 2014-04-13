class Client < ActiveRecord::Base
  include PgSearch

  #create an after create callback to checks if corp .. info has been created despite inc. not being checked, 
  #delete the corporation record

  attr_accessible :name, :name1, :salutation, :locations_attributes, :clientlocations_attributes, :clienttype_id, 
                  :websites_attributes, :phones_attributes, :emails_attributes, :incorporated, :registeredcharity, 
                  :registeredband, :mandate, :corporation_attributes, :charity_attributes, :band_attributes,
                  :divisions_attributes, :projects_attributes, :applications_attributes, :token, :country_id, :created_by, :updated_by
  attr_writer :current_step, :ts
  attr_accessor :country_id

  after_save :org_info_cleanup
  #after_save :update_clientlocation, if: Proc.new { |c| c.clienttype_id==1 }

  has_many :clientlocations, dependent: :destroy
  has_many :locations, through: :clientlocations, dependent: :destroy
  has_many :states, through: :locations 
  has_many :projects, dependent: :destroy
  has_many :contacts, dependent: :destroy
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

  validates :name, presence: true
  validates :clienttype_id, presence: true
  validates :name1, presence: true, if: Proc.new { |c| c.clienttype_id==1 } 


  belongs_to :clienttype
  
  accepts_nested_attributes_for :locations
  accepts_nested_attributes_for :clientlocations
  accepts_nested_attributes_for :clienttype
  accepts_nested_attributes_for :websites, reject_if: lambda { |w| w[:website].blank? }
  accepts_nested_attributes_for :phones
  accepts_nested_attributes_for :emails
  accepts_nested_attributes_for :charity, :allow_destroy=>true
  accepts_nested_attributes_for :band
  accepts_nested_attributes_for :corporation
  accepts_nested_attributes_for :divisions
  accepts_nested_attributes_for :projects
  accepts_nested_attributes_for :applications

  pg_search_scope :search, against: [:name, :name1],
  using: {     
    tsearch: {dictionary: 'english', prefix: true, any_word: true},
    trigram: {}
    #dmetaphone: {}
    },
  associated_against: {projects: [:projectname, :projectdesc], applications: :corporate_file_number,
  commitmentitems: :ci_name, summarycommitments: :sc_name, subservicelines: :ssl_name, productservicelines: :psl_name,
  locations: [:addressline1, :addressline2, :city, :postal], states: :name, contacts: [:firstname, :lastname],
  websites: :website, emails: :email, phones: :phone, divisions: [:name, :name1, :name2] }

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

  def org_info_cleanup
    @corp = Corporation.where(:client_id=>self.id)
    if self.incorporated == false && !@corp.blank?
      Corporation.destroy(@corp.first.id)
    end

    @charity = Charity.where(:client_id=>self.id)
    if self.registeredcharity == false && !@charity.blank?
      Charity.destroy(@charity.first.id)
    end

    @band = Band.where(:client_id=>self.id)
    if self.registeredband == false && !@band.blank?
      Band.destroy(@band.first.id)
    end

  end

  def update_clientlocation
    @clientlocation = Clientlocation.where(:client_id=>self.id)
    if @clientlocation.count == 1
      @cl = Clientlocation.find(@clientlocation.first.id)
      @cl.update_attributes(:addresstype_id=>1) 
    end   

  end

  def self.search_columns
    %w(name emails_clients.email phones_clients.phone websites_clients.website)
  end

  
  


  

  

  
end
