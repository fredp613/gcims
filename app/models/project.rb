class Project < ActiveRecord::Base

  include PgSearch

  attr_accessible :projectdesc, :projectname, :startdate, :enddate, :created_by, :updated_by, :applications_attributes, 
  :token, :projectcontacts_attributes, :contacts_attributes, :budgetitems_attributes, :client_id, 
  :division_id, :other_funding, :updating_unique_attribute

  attr_accessor :other_funding, :updating_unique_attribute

  has_many :projectcontacts, :dependent=>:destroy
  has_many :contacts, through: :projectcontacts

  has_many :applications, :dependent=>:destroy
  has_many :budgetitems, through: :applications
  has_many :commitmentitems, through: :applications
  has_many :summarycommitments, through: :commitmentitems
  has_many :subservicelines, through: :summarycommitments
  has_many :productservicelines, through: :subservicelines
  
  belongs_to :client
  belongs_to :division

  accepts_nested_attributes_for :applications
  accepts_nested_attributes_for :projectcontacts
  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :client
  accepts_nested_attributes_for :budgetitems
  accepts_nested_attributes_for :division
  

  validates :projectname, presence: :true, :if => :unique_attributes_update?
  validates :startdate, presence: :true, :if => :unique_attributes_update?
  validates :enddate, presence: :true, :if => :unique_attributes_update?
  # need to fix this validation for the unique attribute
  validates :division_id, presence: true, if: Proc.new { |p| p.client.clienttype_id == 3 } || :unique_attributes_update?
  
  
  
  validate :validate_date_fields?

  pg_search_scope :search, against: [:projectname, :projectdesc, :startdate, :enddate],
  using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}},
  associated_against: { applications: :corporate_file_number,
  commitmentitems: :ci_name, summarycommitments: :sc_name, subservicelines: :ssl_name, productservicelines: :psl_name,
  client: [:name, :name1], division: [:name, :name1, :name2] }

  def unique_attributes_update?
    !updating_unique_attribute
  end
  

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
