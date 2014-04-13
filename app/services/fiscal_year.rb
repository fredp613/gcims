class FiscalYear

 def initialize(date1, date2)
  @start_date = date1
  @end_date = date2

  
 end

#returns a list of fiscal years based on year
def fiscalyear_by_year_range
  
  @fy1_start = (@start_date.to_i - 1).to_i
  @fy1_end = @start_date.to_i

  @fy2_start = (@end_date.to_i - 1).to_i
  @fy2_end = @end_date.to_i
  
  @fiscalyears = Array.new

  @fy_count = @end_date.to_i - @start_date.to_i

  i = 0
    loop do
      @fiscalyears.push((@fy1_start + i).to_s + "-" + (@fy1_end + i).to_s)
      i += 1 
      break if i > @fy_count
    end

  @fiscalyears

end

def fiscalyear_by_year_range_single
  
  @fy1_start = @start_date - 1
  @fy1_end = @start_date

  @fy2_start = @end_date - 1
  @fy2_end = @end_date 
  
  @fiscalyears = Array.new

  @fy_count = @end_date - @start_date

  i = 0
    loop do
      @fiscalyears.push(@fy1_start + i).to_s
      i += 1 
      break if i > @fy_count
    end

  @fiscalyears

end

#returns a list of fiscal years based on full date range
def fiscalyear_by_date_range

  @start_month = @start_date.month.to_i
  @end_month = @end_date.month.to_i
  @start_year = @start_date.year.to_i
  @end_year = @end_date.year.to_i


  @fiscalyears = Array.new
  @fy1_start = 0
  @fy1_end = 0

  
  #2008
  if @start_month < 4 
  	@fy1_start = @start_year - 1 #2007
  	@fy1_end = @start_year #2008
  else
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
      
    i = 0
    loop do
      @fiscalyears.push((@fy1_start + i).to_s + "-" + (@fy1_start + i + 1).to_s)
      i += 1 
      break if i > @fy_count
    end
    
  else
  	@fy = @fy2_start.to_s + "-" + @fy2_end.to_s
  	@fiscalyears.push(@fy)
  end

 @fiscalyears  
 end







end



