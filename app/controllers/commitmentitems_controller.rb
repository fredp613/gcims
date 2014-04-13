 class CommitmentitemsController < ApplicationController
  # GET /commitmentitems
  # GET /commitmentitems.json
  def index

    #for ajax call
    if params[:psl]
      @ssls = Subserviceline.where(:productserviceline_id=>params[:psl])
      @scs = Summarycommitment.where(:subserviceline_id=>@ssls)
      @commitmentitems = Commitmentitem.where(:summarycommitment_id=>@scs)
    end

    if params[:ssl]
      @scs = Summarycommitment.where(:subserviceline_id=>params[:ssl])
      @commitmentitems = Commitmentitem.where(:summarycommitment_id=>@scs)
    end

    if params[:sc]
      @commitmentitems = Commitmentitem.where(:id=>params[:sc])
    end


    ##############

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commitmentitems }
    end
  end

  # GET /commitmentitems/1
  # GET /commitmentitems/1.json
  def show
    @commitmentitem = Commitmentitem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @commitmentitem }
    end
  end

  # GET /commitmentitems/new
  # GET /commitmentitems/new.json
  def new

    @commitmentitem = current_user.commitmentitems.new(:summarycommitment_id => params[:summarycommitment_id],
      :startdate => params[:startdate], :enddate=>params[:enddate])
    
    if params[:layout]
      render :layout => false
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @subserviceline }
      end
    end
  end

  # GET /commitmentitems/1/edit
  def edit
    @commitmentitem = Commitmentitem.find(params[:id])
    @layout = params[:layout]

    if params[:layout]
      render :layout => false
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @subserviceline }
      end
    end
  end

  # POST /commitmentitems
  # POST /commitmentitems.json
  def create
    @commitmentitem = current_user.commitmentitems.new(params[:commitmentitem])

    respond_to do |format|
      if @commitmentitem.save
        @productservicelines = Productserviceline.all

<<<<<<< HEAD
        format.html { redirect_to commitmentitem_path(@commitmentitem), notice: 'Commitmentitem was successfully created.' }
=======
        format.html { redirect_to productservicelines_path, notice: 'Commitmentitem was successfully created.' }
>>>>>>> fy_refactor
        format.json { render json: @commitmentitem, status: :created, location: @commitmentitem }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @commitmentitem.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /commitmentitems/1
  # PUT /commitmentitems/1.json
  def update
    @commitmentitem = Commitmentitem.find(params[:id])
    @commitmentitem.user = current_user

    respond_to do |format|

      if @commitmentitem.update_attributes(params[:commitmentitem])
        @productservicelines = Productserviceline.all
      
        format.html { redirect_to productservicelines_path, notice: 'Commitmentitem was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @commitmentitem.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /commitmentitems/1
  # DELETE /commitmentitems/1.json
  def destroy
    @commitmentitem = Commitmentitem.find(params[:id])
    @commitmentitem.destroy
    if @subserviceline.errors.any?
      flash[:error] = @subserviceline.errors.full_messages
    else
      flash[:notice] = 'Sub service line item deleted'
    end
    @productservicelines = Productserviceline.all
    respond_to do |format|
      format.html { redirect_to productservicelines_url }
      format.json { head :no_content }
      format.js
    end
  end

  

  

  




end
