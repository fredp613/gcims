class Commitmentitem < ActiveRecord::Base
  attr_accessible :active, :ci_name, :summarycommitment_id, :startdate, :enddate, :fiscalyear_ids, :user_id
  has_many :fyci, :dependent => :delete_all
  #has_many :fiscalyears, through: :fyci
  has_many :applications
  has_many :projects, through: :applications

  belongs_to :summarycommitment
  belongs_to :user
  validates :ci_name, presence: true

  validates :startdate, presence: true
  validates :enddate, presence: true
  validate :startdate_comparison
  validate :enddate_comparison
  validate :check_associations_dates
  
  before_destroy :check_associations
  after_update :update_tree
  
  scope :active, lambda { 
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
      
      last = self.projects.first(:order => 'enddate DESC')
      first = self.projects.first(:order => 'startdate ASC')

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

  def update_tree
    if self.startdate_changed? || self.enddate_changed?      
      ##update up
        if self.summarycommitment.startdate > self.startdate 
          self.summarycommitment.update_attributes(:startdate => self.startdate, :user_id=>self.user_id)
        end

        if self.summarycommitment.enddate < self.enddate
            self.summarycommitment.update_attributes(:enddate => self.enddate, :user_id=>self.user_id)       
        end 

        #unique branch auto updates parent
        unless self.summarycommitment.commitmentitems.count > 1
          self.summarycommitment.update_attributes(:enddate =>self.enddate, :startdate => self.startdate, :user_id=>self.user_id)
        end

    end
  end



end
