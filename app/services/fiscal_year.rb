class FiscalYear

 def initialize(date1, date2)
  @start_date = date1
  @end_date = date2

  
 end

#returns a list of fiscal years based on full date
def fiscalyear

  @start_month = @start_date.month.to_i
  @end_month = @end_date.month.to_i
  @start_year = @start_date.year.to_i
  @end_year = @end_date.year.to_i


  @fiscalyears = Array.new
  @fy1_start = ''
  @fy1_end = ''
  # @fy2_start = nil
  # @fy2_end = nil
  @year1 = ''
  @year2 = ''
  @one = 1
  #2008
  if @start_month < 4 
  	@fy1_start = @start_year - 1 #2007
  	@fy1_end = @start_year #2008
  elsif @start_month > 4
  	@fy1_start = @start_year #2008
  	@fy1_end = @start_year + 1 #2009
  end

  #2008
  if @end_month < 4
  	@fy2_start = @end_year - 1 #2007
  	@fy2_end = @end_year #2008
  else
  	@fy2_start = @end_year  #2008
    @fy2_end = @end_year + 1 #2009
  end

  if @fy2_end - @fy1_end > 0
   
    @fy_count = @fy2_end - @fy1_end 
  	
    
    @fys = 0..@fy_count.to_i
    @fys.each do |i|
      @fiscalyears.push((@fy1_start + i).to_s + " " + (@fy1_start + i + 1).to_s)
    end
    
  else
  	@fy = @fy2_start.to_s + "-" + @fy2_end.to_s
  	@fiscalyears.push(@fy)
  end

 @fiscalyears  
 end



end



