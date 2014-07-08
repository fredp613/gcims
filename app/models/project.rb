class Project < ActiveRecord::Base

  include PgSearch
  include ActiveModel::Dirty

  attr_accessible :projectdesc, :projectname, :startdate, :enddate, :created_by, :updated_by, :applications_attributes, 
  :token, :projectcontacts_attributes, :contacts_attributes, :budgetitems_attributes, :client_id, 
  :division_id, :other_funding, :updating_unique_attribute



  attr_accessor :other_funding, :updating_unique_attribute

  has_many :projectcontacts, :dependent=>:destroy
  has_many :contacts, through: :projectcontacts

  has_many :applications, :dependent=>:destroy
  has_many :budgetitems, through: :applications
  has_many :commitmentitems, through: :applications
  has_many :applicationcustomtemplates, through: :applications
  has_many :summarycommitments, through: :commitmentitems
  has_many :subservicelines, through: :summarycommitments
  has_many :productservicelines, through: :subservicelines
  has_many :emails, through: :client
  has_many :websites, through: :client
  
  belongs_to :client
  belongs_to :division

  accepts_nested_attributes_for :applications
  accepts_nested_attributes_for :projectcontacts
  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :client
  accepts_nested_attributes_for :budgetitems
  accepts_nested_attributes_for :division
  
#also add || is in state create
  validates :projectname, presence: :true, :if => :projectname_changed? 
  # validates :startdate, presence: :true#, :if => :startdate_changed? 
  # validates :enddate, presence: :true#, :if => :enddate_changed? 

  # need to fix this validation for the unique attribute
  validates :division_id, presence: true, if: Proc.new { |p| p.client.clienttype_id == 3 } || :division_id_changed?
  

  # validate :startdate_comparison
  # validate :enddate_comparison
  #validate :dates_budgetitem_fiscalyears_comparison, :on=>:update


  pg_search_scope :search, against: [:projectname, :projectdesc, :startdate, :enddate], using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}},
  associated_against: { applications: :corporate_file_number,
  commitmentitems: :ci_name, summarycommitments: :sc_name, subservicelines: :ssl_name, productservicelines: :psl_name,
  client: [:name, :name1], division: [:name, :name1, :name2], emails: [:email], websites: [:website] }

  

  def has_active_specific_template?
    # revisit this - you may want to allow specific template at project or application level rather than program level
    # apps = Application.where(project_id: self.id)
    # ct = Applicationcustomtemplate.where(application_id: apps.map(&:id))
    
    apps = Application.where(project_id: self.id)
    ct = Cict.programspecifictemplate(apps.map(&:commitmentitem_id), nil)

    if ct.size > 0  
      true
    else
      false
    end
  end

  def has_specific_data?
    apps = Application.where(project_id: self.id)
    acts = Applicationcustomtemplate.where(application_id: apps.map(&:id))
    if Customfieldvalue.where(applicationcustomtemplate_id: acts.map(&:id)).count > 0
      true
    else
      false
    end
  end

  def not_unique_attributes_update?
    !updating_unique_attribute 
  end
  

   def self.text_search(query)
    if query.present?
      search(query)
    else
      where(nil)
    end
  end 


  def startdate_comparison     
    return if !startdate_changed? || startdate.blank?
    if enddate < startdate               
        errors.add(:startdate, 'must be smaller than end date')                
    end
  end

  def enddate_comparison     
    return if !enddate_changed? || enddate.blank?
    if enddate < startdate                       
     errors.add(:enddate, 'must be greater than start date')                 
    end
  end

  def dates_budgetitem_fiscalyears_comparison
    #select distinct fiscalyears in budgetitems into array
    #get fiscal year range from fiscal years using new start and enddate values (in not blanks)
    #compaire both arrays and seek differences - differences into new array which will
    #be part of the error displayed to user

    @fy_budgetitems = Array.new

    self.budgetitems.each do |b|
      @fy_budgetitems.push(b.fiscalyear_id)
    end

    @fy_dates = Fiscalyear.year_range(startdate, enddate).map(&:id)

   # @difference = @fy_budgetitems - @fy_dates
    @diff = @fy_budgetitems.reject{ |f| @fy_dates.include? f }

    #@ssl.fiscalyear_ids.reject{ |e| @psl.fiscalyear_ids.include? e}
    
    if @diff.size > 0
      @fiscalyears = Fiscalyear.where(:id=>@diff).order(:fy).to_a

      if startdate_changed?         
        errors.add(:startdate, 
          'Before changing the start date
          please ensure that there are no expense items in
          the following fiscal years:'+ " " + @fiscalyears.map(&:fy).join(', '))
      elsif enddate_changed?
        errors.add(:enddate, 
          'Before changing the end date
          please ensure that there are no expense items in
          the following fiscal years:'+ " " + @fiscalyears.map(&:fy).join(', '))
      end

      
    end



  end






 

  

end
