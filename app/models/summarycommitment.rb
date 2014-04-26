class Summarycommitment < ActiveRecord::Base
  attr_accessible :active, :sc_name, :subserviceline_id, :commitmentitems_attributes, 
  :startdate, :enddate, :fiscalyear_ids, :user_id, :ci_name

  attr_accessor :ci_name

  has_many :commitmentitems, :dependent => :destroy
  has_many :applications, through: :commitmentitems
  has_many :projects, through: :commitmentitems
  has_many :fysc, :dependent => :delete_all
 
  
  belongs_to :subserviceline
  belongs_to :user
  accepts_nested_attributes_for :commitmentitems

  validates :sc_name, presence: true

  validates :startdate, presence: true
  validates :enddate, presence: true
  validate :startdate_comparison
  validate :enddate_comparison
  validate :check_associations_dates
  
  after_create :create_tree
  after_update :update_tree
  before_destroy :check_associations
  

  scope :active, -> { 
    where('enddate >= ?', Date.today).where('startdate <= ?', Date.today)
  }

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

  def fiscalyears
    @fys = FiscalYear.new(self.startdate.to_date, self.enddate.to_date).fiscalyear_by_date_range
    @fys
  end

  def create_tree
    @ci = self.commitmentitems.new
    @ci.ci_name = self.ci_name
    @ci.startdate = self.startdate
    @ci.enddate = self.enddate
    @ci.summarycommitment_id = self.id 
    @ci.user = self.user
    @ci.save

  end

  def update_tree

    if self.startdate_changed? || self.enddate_changed?      

      #update down
      sd = self.startdate
      ed = self.enddate

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
       ##update up
          if self.subserviceline.startdate > self.startdate 
            self.subserviceline.update_attributes(:startdate => self.startdate, :user_id=>self.user_id)
          end

          if self.subserviceline.enddate < self.enddate
              self.subserviceline.update_attributes(:enddate => self.enddate, :user_id=>self.user_id)       
          end 

        #unique branch auto updates parent
        unless self.subserviceline.summarycommitments.count > 1
          self.subserviceline.update_attributes(:enddate =>self.enddate, :startdate => self.startdate, :user_id=>self.user_id)
        end

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
    
    if self.projects.exists?
      
      last = self.projects(:order => 'enddate DESC').first
      first = self.projects(:order => 'startdate ASC').first

      if (last.enddate > self.enddate) || (first.startdate < self.startdate)

        if last.enddate > self.enddate
           errors.add(:enddate, "There are projects that exist with later dates than the one you have chosen
            therefore you cannot change the end date of this pras item unless you modify the end date of those projects.
             The end date cannot be less than #{last.enddate.to_date} which is corporate file number: #{first.applications.first.corporate_file_number}")         
        end

        
        if first.startdate < self.startdate
           errors.add(:startdate, "There are projects that exist with lower start dates than than the one you have chosen
            therefore you cannot change the start date of this pras item unless you modify the start date of those projects.
             The start date cannot be less than #{first.startdate.to_date} which is corporate file number: #{first.applications.first.corporate_file_number}")
        end

      end
    end

  end
  
end
