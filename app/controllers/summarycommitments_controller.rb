class SummarycommitmentsController < ApplicationController
  # GET /summarycommitments
  # GET /summarycommitments.json
  def index
   
    #ajax calls
    if params[:psl]
      @ssls = Subserviceline.active.where(:productserviceline_id=>params[:psl])
      @summarycommitments = Summarycommitment.active.where(:subserviceline_id=>@ssls)
    end

    if params[:ssl]
      @summarycommitments = Summarycommitment.active.where(:subserviceline_id=>params[:ssl])
    end

    if params[:ci]
      @sc_id = Commitmentitem.active.where(:id=>params[:ci]).first.summarycommitment_id
      @summarycommitments = Summarycommitment.active.where(:id=>@sc_id)
    end
    ###########


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
      :startdate => params[:startdate], :enddate=>params[:enddate])
    build

    if params[:layout]
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

    if params[:layout]
      render :layout => false
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @subserviceline }
      end
    end
  end

  # POST /summarycommitments
  # POST /summarycommitments.json
  def create
    @summarycommitment = current_user.summarycommitments.new(params[:summarycommitment])

    respond_to do |format|
      if @summarycommitment.save

<<<<<<< HEAD
        @subserviceline = @summarycommitment.subserviceline
        @productserviceline = @subserviceline.productserviceline

        @updatetree = UpdateTree.new(current_user, @productserviceline, @subserviceline, @summarycommitment, nil, "sc", "update", params)  
        @updatetree.update_tree_instances


        format.html { redirect_to summarycommitment_path(@summarycommitment), notice: 'Summarycommitment was successfully created.' }
=======
        @productservicelines = Productserviceline.all
        format.html { redirect_to productservicelines_path, notice: 'Summarycommitment was successfully created.' }
>>>>>>> fy_refactor
        format.json { render json: @summarycommitment, status: :created, location: @summarycommitment }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @summarycommitment.errors, status: :unprocessable_entity }
        format.js
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
        @productservicelines = Productserviceline.all

        format.html { redirect_to productservicelines_path, notice: 'Summarycommitment was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @summarycommitment.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /summarycommitments/1
  # DELETE /summarycommitments/1.json
  def destroy
    @summarycommitment = Summarycommitment.find(params[:id])
    @summarycommitment.destroy

    if @subserviceline.errors.any?
      flash[:error] = @subserviceline.errors.full_messages
    else
      flash[:notice] = 'Sub service line item deleted'
    end
    @productservicelines = Productserviceline.all
    
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
