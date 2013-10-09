class Project < ActiveRecord::Base

  include PgSearch

  attr_accessible :projectdesc, :projectname, :startdate, :enddate, :applications_attributes, 
  :token, :projectcontacts_attributes, :contacts_attributes, :budgetitems_attributes, :client_id

  has_many :projectcontacts, :dependent=>:destroy
  has_many :contacts, through: :projectcontacts

  has_many :applications
  has_many :budgetitems, through: :applications
  has_many :commitmentitems, through: :applications
  has_many :summarycommitments, through: :commitmentitems
  has_many :subservicelines, through: :summarycommitments
  has_many :productservicelines, through: :subservicelines
  
  belongs_to :client

  accepts_nested_attributes_for :applications
  accepts_nested_attributes_for :projectcontacts
  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :client
  accepts_nested_attributes_for :budgetitems

  validates :projectname, presence: true
  validates :startdate, presence: true
  validates :enddate, presence: true
  
  
  
  validate :validate_date_fields?



  pg_search_scope :search, against: [:projectname, :projectdesc, :startdate, :enddate],
  using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}},
  associated_against: { applications: :corporate_file_number,
  commitmentitems: :ci_name, summarycommitments: :sc_name, subservicelines: :ssl_name, productservicelines: :psl_name,
  client: [:name, :name1] }

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end 

  def validate_date_fields?     
    return if [enddate.blank?, startdate.blank?].any?
    if enddate < startdate
      errors.add(:startdate, 'must be smaller than end date')
    end
  end

 

  

end
