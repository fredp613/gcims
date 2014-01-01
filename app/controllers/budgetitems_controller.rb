class BudgetitemsController < ApplicationController
  # GET /budgetitems
  # GET /budgetitems.json

 # before_filter :set_instance_variables, only: [:create]

  def index
    @budgetitems = Budgetitem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @budgetitems }
    end
  end

  # GET /budgetitems/1
  # GET /budgetitems/1.json
  def show
    @budgetitem = Budgetitem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @budgetitem }
    end
  end

  # GET /budgetitems/new
  # GET /budgetitems/new.json
  def new
    @budgetitem = Budgetitem.new
      
    if params[:application_id].present?
      if @budgetitem.application_id.blank?
        @budgetitem.application_id = params[:application_id]
      end
    
    elsif params[:project_id].present?
      @project = Project.find(params[:project_id])
      @budgetitem.application_id = @project.applications.first.id
    end

    if @budgetitem.funding_source.blank?

      if params[:other_funder].present?
        @budgetitem.funding_source = nil   
      else
        @budgetitem.funding_source = "Justice Canada"
      end

    end

    @budgetitem.fiscalyear_range = Fiscalyear.year_range(@budgetitem.application.project.startdate, @budgetitem.application.project.enddate)
    


    @budgetitem.apptypes = 
    Applicationtype.joins(:applications).select('applications.id, applicationtypes.name')
    .where('applications.id = (?)', @budgetitem.application_id)

    
   

    respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @budgetitem}
        format.js
        
    end
  end

  # GET /budgetitems/1/edit
  def edit
    @budgetitem = Budgetitem.find(params[:id])
    @budgetitem.apptypes = 
    Applicationtype.joins(:applications).select('applications.id, applicationtypes.name')
    .where('applications.id = (?)', @budgetitem.application_id)

    respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @project}
        format.js        
    end
    

  end

  # POST /budgetitems
  # POST /budgetitems.json
  def create

    @fys = params[:fiscalyear_ids]
    @fiscalyears = Array.new

    if @fys 

      @fys.each do |fy|
        @budgetitem = Budgetitem.new(params[:budgetitem])
        @budgetitem.fiscalyear_id = fy        
        @fiscalyears.push(fy)
      end


    else
      @budgetitem = Budgetitem.new(params[:budgetitem])
    end

    @project = Project.find(@budgetitem.application.project_id)

 
    #redirect_to project_path(@budgetitem.application.project)
    

    respond_to do |format|
      if (@budgetitem.funding_source != 'Justice Canada') ? @budgetitem.balanced_budget(@fiscalyears.count, 'new', 0, 0, true) : @budgetitem.balanced_budget(@fiscalyears.count, 'new') 
         if @fys 
          @fys.each do |fy|
              @budgetitem = Budgetitem.new(params[:budgetitem])
              @budgetitem.fiscalyear_id = fy    
              @budgetitem.save 
          end    
        end  
            if @budgetitem.save
               
                flash[:notice] = 'Expense item updated'
                format.html { redirect_to project_path(@budgetitem.application.project) }
                format.json { render json: @budgetitem, status: :created, location: @budgetitem }  
                format.js              
            
            else
              
             @budgetitem.fiscalyears = params[:fiscalyear_ids].map(&:to_i) unless params[:fiscalyear_ids].blank?      
             @budgetitem.project = params[:project]
              @budgetitem.apptypes = 
              Applicationtype.joins(:applications).select('applications.id, applicationtypes.name')
              .where('applications.id = (?)', @budgetitem.application_id)   

              if params[:project_id]
                @project = Project.where(:id=>params[:project_id])
              end
             
              
              @budgetitem.fiscalyear_range = Fiscalyear.year_range(@budgetitem.application.project.startdate, @budgetitem.application.project.enddate)

              format.html { render action: "new" }
              format.json { render json: @budgetitem.errors, status: :unprocessable_entity }
              format.js
            end
      else     
         @budgetitem.fiscalyears = params[:fiscalyear_ids].map(&:to_i) unless params[:fiscalyear_ids].blank?      
         @budgetitem.project = params[:project]
          @budgetitem.apptypes = 
          Applicationtype.joins(:applications).select('applications.id, applicationtypes.name')
          .where('applications.id = (?)', @budgetitem.application_id)

        if params[:project_id]
          @project = Project.where(:id=>params[:project_id])
        end
        @budgetitem.fiscalyear_range = Fiscalyear.year_range(@budgetitem.application.project.startdate, @budgetitem.application.project.enddate)

        format.html { render action: "new", :project=>@budgetitem.project }
        format.json { render json: @budgetitem.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end 



  # PUT /budgetitems/1
  # PUT /budgetitems/1.json
  def update
    @budgetitem = Budgetitem.find(params[:id])

    @project = Project.find(@budgetitem.application.project_id)

    respond_to do |format|

      @budgetitem.forecast_will_change!
      @budgetitem.forecast = params[:budgetitem][:forecast]

      @before_value = @budgetitem.forecast_was
      @after_value = @budgetitem.forecast

      if (@budgetitem.funding_source != 'Justice Canada') ? @budgetitem.balanced_budget(0, 'edit', @before_value, @after_value, true) : @budgetitem.balanced_budget(0, 'edit', @before_value, @after_value) 
        if @budgetitem.update_attributes(params[:budgetitem]) 
          flash[:notice] = 'Expense item updated'
          format.html { redirect_to project_path(@budgetitem.application.project) }
          format.json { head :no_content }
          format.js
        else
          flash[:notice] = 'Expense item updated'
          format.html { render action: "edit" }
          format.json { render json: @budgetitem.errors, status: :unprocessable_entity }
          format.js
        end
      else
          format.html { render action: "edit" }
          format.json { render json: @budgetitem.errors, status: :unprocessable_entity }
          format.js
      end
    end

  end

  # DELETE /budgetitems/1
  # DELETE /budgetitems/1.json
  def destroy
    @budgetitem = Budgetitem.find(params[:id])
    
    @budgetitem.destroy
    @project = Project.find(@budgetitem.application.project_id)
    flash[:notice] = 'Expense item deleted'
    respond_to do |format|
      format.html { redirect_to project_path(@budgetitem.application.project) }
      format.json { head :no_content }
      format.js
    end
    
  end

  def set_instance_variables
     @budgetitem = Budgetitem.find(params[:id])
    # @fiscalyears = Fiscalyear.year_range(@budgetitem.application.project.startdate, @budgetitem.application.project.enddate)
    
  end
end
