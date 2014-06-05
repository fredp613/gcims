class Productserviceline < ActiveRecord::Base

  include ActiveModel::Dirty

  self.table_name = "productservicelines"
  attr_accessible :psl_name, :active, :subservicelines_attributes, 
  :summarycommitments_attributes, :commitmentitems_attributes, :startdate, :enddate,:fiscalyear_ids,
  :ssl_name, :sc_name, :ci_name, :user_id

  #form fields (on create)
  attr_accessor :ssl_name, :sc_name, :ci_name

  has_many :subservicelines, :dependent => :destroy
  has_many :summarycommitments, :through => :subservicelines
  has_many :commitmentitems, :through => :summarycommitments
  has_many :applications, through: :commitmentitems
  has_many :projects, through: :applications
  has_many :fypsls, :dependent => :destroy
  
  

  scope :active, -> { 
    where('enddate >= ?', Date.today).where('startdate <= ?', Date.today)
  }


  belongs_to :user

  accepts_nested_attributes_for :subservicelines
  accepts_nested_attributes_for :summarycommitments
  accepts_nested_attributes_for :commitmentitems

  validates :psl_name, presence: true
  validates :startdate, presence: true
  validates :enddate, presence: true
  validate :startdate_comparison
  validate :enddate_comparison
  validate :check_associations_dates  

  after_create :create_tree
  after_update :update_tree
  before_destroy :check_associations
  

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

  def create_tree

    @ssl = self.subservicelines.new
    @ssl.ssl_name = self.ssl_name
    @ssl.startdate = self.startdate
    @ssl.enddate = self.enddate
    @ssl.productserviceline_id = self.id
    @ssl.user = self.user
    @ssl.save

    @sc = self.summarycommitments.new
    @sc.sc_name = self.sc_name
    @sc.startdate = self.startdate
    @sc.enddate = self.enddate
    @sc.subserviceline_id = @ssl.id
    @sc.user = self.user
    @sc.save

    @ci = @sc.commitmentitems.new
    @ci.ci_name = self.ci_name
    @ci.startdate = self.startdate
    @ci.enddate = self.enddate
    @ci.summarycommitment_id = @sc.id 
    @ci.user = self.user
    @ci.save

  end

  def update_tree

    #first get allowable date range - if any of the children fall outside of this range update them.
    sd = self.startdate
    ed = self.enddate

    self.subservicelines.each do |ssl|
      #start date in range - end date out of range
      if (ssl.startdate >= sd && ssl.startdate <= ed) && !(ssl.enddate >= sd && ssl.enddate <= ed)
        ssl.update_attributes(:enddate => ed, :user_id=>self.user_id)
      end
      #start date out of range - end date in range
      if !(ssl.startdate >= sd && ssl.startdate <= ed) && (ssl.enddate >= sd && ssl.enddate <= ed)
        ssl.update_attributes(:startdate => sd, :user_id=>self.user_id)
      end
      #start and enddate out of range
      if !(ssl.startdate >= sd && ssl.startdate <= ed) && !(ssl.enddate >= sd && ssl.enddate <= ed)
        ssl.update_attributes(:startdate => sd, :enddate => ed, :user_id=>self.user_id)
      end

    end

    self.summarycommitments.each do |sc|
      #start date in range - end date out of range
      if (sc.startdate >= sd && sc.startdate <= ed) && !(sc.enddate >= sd && sc.enddate <= ed)
        sc.update_attributes(:enddate => ed, :user_id=>self.user_id)
      end
      #start date out of range - end date in range
      if !(sc.startdate >= sd && sc.startdate <= ed) && (sc.enddate >= sd && sc.enddate <= ed)
        sc.update_attributes(:startdate => sd, :user_id=>self.user_id)
      end
      #start and enddate out of range
      if !(sc.startdate >= sd && sc.startdate <= ed) && !(sc.enddate >= sd && sc.enddate <= ed)
        sc.update_attributes(:startdate => sd, :enddate => ed, :user_id=>self.user_id)
      end

    end

    self.commitmentitems.each do |ci|
      #start date in range - end date out of range
      if (ci.startdate >= sd && ci.startdate <= ed) && !(ci.enddate >= sd && ci.enddate <= ed)
        ci.update_attributes(:enddate => ed, :user_id=>self.user_id)
      end
      #start date out of range - end date in range
      if !(ci.startdate >= sd && ci.startdate <= ed) && (ci.enddate >= sd && ci.enddate <= ed)
        ci.update_attributes(:startdate => sd, :user_id=>self.user_id)
      end
      #start and enddate out of range
      if !(ci.startdate >= sd && ci.startdate <= ed) && !(ci.enddate >= sd && ci.enddate <= ed)
        ci.update_attributes(:startdate => sd, :enddate => ed, :user_id=>self.user_id)
      end

    end

    #check if active - if not active then children shold not be active
    


  end

  def fiscalyears
    @fys = FiscalYear.new(self.startdate.to_date, self.enddate.to_date).fiscalyear_by_date_range
    @fys
  end

#refactor these entirely - sy and ey are fiscal years!! You're going to have to create 
#variables that will extract the year and months from 
  def self.active_between(sy, ey)
    sd = sy + '-04-01'
    ed = ey + '-03-31'
    @active = self.where('startdate >= (?) AND enddate <= (?)', sd, ed)
    @active
  end

  def self.active_range(sd, ed, sy, ey)
    p_sd = sy.to_s + '-04-01'
    p_ed = ey + '-03-31'
    
    if ((ed <= p_ed) && (ed >= p_sd)) || (((sd<=p_sd) && (ed>=p_sd)) && (sd <= p_ed)) || ((ed >= p_ed) && (sd <= p_ed))
      true
    else
      false
    end 
  end

   def check_associations
    if self.applications.exists?
      errors.add(:base, "You cannot delete this branch because this branch has projects - If you want to deactivate it,
      you can change the end date of this branch. You can also transfer all the projects under this branch to another 
      PRAS branch and delete the branch afterwards")
      return false
    else
      return true
    end    
  end

 def check_associations_dates
    
    if self.applications.exists?
      
      last = self.applications(:order => 'enddate DESC').first
      first = self.applications(:order => 'startdate ASC').first

      if (last.enddate > self.enddate) || (first.startdate < self.startdate)

        if last.enddate > self.enddate
           errors.add(:enddate, "There are projects that exist with later dates than the one you have chosen
            therefore you cannot change the end date of this pras item unless you modify the end date of those projects.
             The end date cannot be less than #{last.enddate.to_date} which is corporate file number: #{first.corporate_file_number}")         
        end

        
        if first.startdate < self.startdate
           errors.add(:startdate, "There are projects that exist with lower start dates than than the one you have chosen
            therefore you cannot change the start date of this pras item unless you modify the start date of those projects.
             The start date cannot be less than #{first.startdate.to_date} which is corporate file number: #{first.corporate_file_number}")
        end

      end
    end

  end



end
