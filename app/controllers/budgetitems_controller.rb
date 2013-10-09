class BudgetitemsController < ApplicationController
  # GET /budgetitems
  # GET /budgetitems.json
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
    @project = params[:project]

    @applications = Application.where(:project_id=>@project)

    @apptypes = Applicationtype.joins(:applications).select('applications.id, applicationtypes.name').where('applications.id'=>@applications)
    @app = Application.joins(:applicationtype)


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @budgetitem }
    end
  end

  # GET /budgetitems/1/edit
  def edit
    @budgetitem = Budgetitem.find(params[:id])
    @apptypes = Applicationtype.joins(:applications).select('applications.id, applicationtypes.name').where('applications.id'=>@budgetitem.application_id)

  end

  # POST /budgetitems
  # POST /budgetitems.json
  def create

    @fys = params[:fiscalyear_ids]

    @fys.each do |fy|
      @budgetitem = Budgetitem.new(params[:budgetitem])
      @budgetitem.fiscalyear_id = fy
      @budgetitem.save
    end
 
    #redirect_to project_path(@budgetitem.application.project)
    

    respond_to do |format|
      if @budgetitem.save
        format.html { redirect_to project_path(@budgetitem.application.project), notice: 'Budgetitem was successfully created.' }
        format.json { render json: @budgetitem, status: :created, location: @budgetitem }
      else
        format.html { render action: "new" }
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
end
