class CommitmentitemsController < ApplicationController
  # GET /commitmentitems
  # GET /commitmentitems.json
  def index

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
      :fiscalyear_ids => params[:fiscalyear_ids])
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

  # GET /commitmentitems/1/edit
  def edit
    @commitmentitem = Commitmentitem.find(params[:id])
    @layout = params[:layout]

    if @layout='false'
      render :layout => false
    end
  end

  # POST /commitmentitems
  # POST /commitmentitems.json
  def create
    @commitmentitem = current_user.commitmentitems.new(params[:commitmentitem])

    respond_to do |format|
      if @commitmentitem.save
        @summarycommitment = @commitmentitem.summarycommitment
        @subserviceline = @summarycommitment.subserviceline
        @productserviceline = @subserviceline.productserviceline

        @updatetree = UpdateTree.new(current_user, @productserviceline, @subserviceline, @summarycommitment, @commitmentitem,"ci", "update", params)  
        @updatetree.update_tree_instances

        format.html { redirect_to commitmentitem_path(@commitmentitem), notice: 'Commitmentitem was successfully created.' }
        format.json { render json: @commitmentitem, status: :created, location: @commitmentitem }
      else
        format.html { render action: "new" }
        format.json { render json: @commitmentitem.errors, status: :unprocessable_entity }
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
        @summarycommitment = @commitmentitem.summarycommitment
        @subserviceline = @summarycommitment.subserviceline
        @productserviceline = @subserviceline.productserviceline

        @updatetree = UpdateTree.new(current_user, @productserviceline, @subserviceline, @summarycommitment, @commitmentitem,"ci", "update", params)  
        @updatetree.update_tree_instances
       
        format.html { redirect_to @commitmentitem, notice: 'Commitmentitem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @commitmentitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commitmentitems/1
  # DELETE /commitmentitems/1.json
  def destroy
    @commitmentitem = Commitmentitem.find(params[:id])
    @commitmentitem.destroy

    respond_to do |format|
      format.html { redirect_to productservicelines_url }
      format.json { head :no_content }
    end
  end

  def fys
    @fys = @commitmentitem.fiscalyear_ids
    if @fys_count = 0
      @commitmentitem.active = false
    else
      @commitmentitem.active
    end

    return @commitmentitem.active
  end  

  def update_tree

    @sc = @commitmentitem.summarycommitment
    @ssl = @sc.subserviceline
    @psl = @ssl.productserviceline

    @cis = @sc.commitmentitems.find(:all)
    @scs = @ssl.summarycommitments.find(:all)
    @ssls = @psl.subservicelines.find(:all)

    if @fys_count = 0
      @commitmentitem.update_attribute(:active, false)

    end 
    

    if @cis_count = 1
      @sc.active = fys
      @sc.fiscalyear_ids = @commitmentitem.fiscalyear_ids
      @sc.update_attributes(:fiscalyear_ids => @commitmentitem.fiscalyear_ids, :active => @commitmentitem.active)

    end

    if @scs_count = 1
      @ssl.active = fys
      @ssl.fiscalyear_ids = @commitmentitem.fiscalyear_ids
      @ssl.update_attributes(:fiscalyear_ids => @commitmentitem.fiscalyear_ids, :active => @commitmentitem.active)
 
    end

    if @ssls_count = 1
      @psl.active = fys
      @psl.fiscalyear_ids = @commitmentitem.fiscalyear_ids
      @psl.update_attributes(:fiscalyear_ids => @commitmentitem.fiscalyear_ids, :active => @commitmentitem.active)
  
    end

  end

  




end
