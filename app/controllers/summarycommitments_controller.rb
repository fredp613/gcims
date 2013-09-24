class SummarycommitmentsController < ApplicationController
  # GET /summarycommitments
  # GET /summarycommitments.json
  def index
    @summarycommitments = Summarycommitment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @summarycommitments }
    end
  end

  # GET /summarycommitments/1
  # GET /summarycommitments/1.json
  def show
    @summarycommitment = Summarycommitment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @summarycommitment }
    end
  end

  # GET /summarycommitments/new
  # GET /summarycommitments/new.json
  def new
    @summarycommitment = Summarycommitment.new(:subserviceline_id => params[:subserviceline_id],
      :fiscalyear_ids => params[:fiscalyear_ids])
    build

    @layout = params[:layout]
    if @layout='false'   
      render :layout => false    
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @subserviceline }
      end
    end
  end

  # GET /summarycommitments/1/edit
  def edit

    @summarycommitment = Summarycommitment.find(params[:id])

    @layout = params[:layout]
    if @layout='false'
      render :layout => false
    end
  end

  # POST /summarycommitments
  # POST /summarycommitments.json
  def create
    @summarycommitment = current_user.summarycommitments.new(params[:summarycommitment])

    respond_to do |format|
      if @summarycommitment.save

        @subserviceline = @summarycommitment.subserviceline
        @productserviceline = @subserviceline.productserviceline

        @updatetree = UpdateTree.new(current_user, @productserviceline, @subserviceline, @summarycommitment, nil, "sc", "update", params)  
        @updatetree.update_tree_instances


        format.html { redirect_to @summarycommitment, notice: 'Summarycommitment was successfully created.' }
        format.json { render json: @summarycommitment, status: :created, location: @summarycommitment }
      else
        format.html { render action: "new" }
        format.json { render json: @summarycommitment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /summarycommitments/1
  # PUT /summarycommitments/1.json
  def update
    @summarycommitment = Summarycommitment.find(params[:id])
    @summarycommitment.user = current_user
    respond_to do |format|
      if @summarycommitment.update_attributes(params[:summarycommitment])
        
        @subserviceline = @summarycommitment.subserviceline
        @productserviceline = @subserviceline.productserviceline

        @updatetree = UpdateTree.new(current_user, @productserviceline, @subserviceline, @summarycommitment, nil, "sc", "update", params)  
        @updatetree.update_tree_instances


        format.html { redirect_to @summarycommitment, notice: 'Summarycommitment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @summarycommitment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /summarycommitments/1
  # DELETE /summarycommitments/1.json
  def destroy
    @summarycommitment = Summarycommitment.find(params[:id])
    @summarycommitment.destroy

    respond_to do |format|
      format.html { redirect_to productservicelines_url }
      format.json { head :no_content }
    end
  end

  private
  def build
    @summarycommitment.commitmentitems.build 
  end

end
