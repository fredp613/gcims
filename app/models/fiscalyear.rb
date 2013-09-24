class Fiscalyear < ActiveRecord::Base
  attr_accessible :fy, :startdate, :enddate

  has_many :fypsls
  has_many :fyssls
  has_many :fyscs
  has_many :fycis
  has_many :productservicelines, through: :fypsls
  has_many :subservicelines, through: :fypsls
  has_many :summarycommitments, through: :fyssls
  has_many :commitmentitems, through: :fycis

  scope :by_fiscalyear, lambda { |fiscalyear_id| where(:id => fiscalyear_id.reject!(&:blank?)) }

  def self.search(fy1=0, fy2=0)
    @fy1 = fy1.to_i
    @fy2 = fy2.to_i
    
    if @fy2 != 0 && @fy1==0
    where(:id => @fy2)
    elsif @fy2==0 && @fy1 !=0
    where(:id => @fy1)
    elsif @fy2 != 0 && @fy1 !=0
    where(:id => @fy1..@fy2)  
    else
    scoped
    end
  end

end
