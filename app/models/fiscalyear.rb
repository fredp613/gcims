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

  scope :by_fiscalyear, -> { |fiscalyear_id| where(:id => fiscalyear_id.reject!(&:blank?)) }

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


  def self.year_range(start_date='', end_date='')
    @start_date = start_date
    @end_date = end_date

    if @start_date != '' || @end_date != ''
      #get month from start_date and end_date
      @start_month = @start_date.month.to_i
      @end_month = @end_date.month.to_i
      @start_year = @start_date.year
      @end_year = @end_date.year

      if @start_month.between?(4,12)
        @start_year = @start_date.year.to_i + 1    
      end

      if @end_month.between?(4,12)
        @end_year = @end_date.year.to_i + 1    
      end
      
      @range = self.where('SUBSTRING(fy from 6 for 4) between ? AND ?', @start_year.to_s, @end_year.to_s).order(:fy)

      @range
    end
  end


end
