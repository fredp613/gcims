class BudgetitemsController < ApplicationController
  # GET /budgetitems
  # GET /budgetitems.json

  #before_filter :set_instance_variables, only: [:new, :create]

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

 

    #@applications = Application.where(:project_id=>@budgetitem.project)

    @budgetitem.apptypes = 
    Applicationtype.joins(:applications).select('applications.id, applicationtypes.name')
    .where('applications.id'=>@budgetitem.application_id)
   


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @budgetitem }
    end
  end

  # GET /budgetitems/1/edit
  def edit
    @budgetitem = Budgetitem.find(params[:id])
    @budgetitem.apptypes = 
    Applicationtype.joins(:applications).select('applications.id, applicationtypes.name')
    .where('applications.id'=>@budgetitem.application_id)

  end

  # POST /budgetitems
  # POST /budgetitems.json
  def create

    @fys = params[:fiscalyear_ids]


    if @fys 

      @fys.each do |fy|
        @budgetitem = Budgetitem.new(params[:budgetitem])
        @budgetitem.fiscalyear_id = fy
        @budgetitem.save
      end
    else
      @budgetitem = Budgetitem.new(params[:budgetitem])
    end

 
    #redirect_to project_path(@budgetitem.application.project)
    

    respond_to do |format|
      if @budgetitem.save
        format.html { redirect_to project_path(@budgetitem.application.project), notice: 'Budgetitem was successfully created.' }
        format.json { render json: @budgetitem, status: :created, location: @budgetitem }
      else
         if !@budgetitem.fiscalyears.blank?     
           @budgetitem.fiscalyears = params[:fiscalyear_ids].map(&:to_i) 
          end
         @budgetitem.project = params[:project]
          @budgetitem.apptypes = 
          Applicationtype.joins(:applications).select('applications.id, applicationtypes.name')
          .where('applications.id'=>@budgetitem.application_id)   

        if params[:project_id]
          @project = Project.where(:id=>params[:project_id])
        end

        format.html { render action: "new", :project=>@budgetitem.project }
        format.json { render json: @budgetitem.errors, status: :unprocessable_entity }
      end
    end
  end



  # PUT /budgetitems/1
  # PUT /budgetitems/1.json
  def update
    @budgetitem = Budgetitem.find(params[:id])

    respond_to do |format|
      if @budgetitem.update_attributes(params[:budgetitem])
        format.html { redirect_to project_path(@budgetitem.application.project), notice: 'Budgetitem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @budgetitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgetitems/1
  # DELETE /budgetitems/1.json
  def destroy
    @budgetitem = Budgetitem.find(params[:id])
    @budgetitem.destroy

    respond_to do |format|
      format.html { redirect_to project_path(@budgetitem.application.project) }
      format.json { head :no_content }
    end
  end

  def set_instance_variables
    
    
  end
end
