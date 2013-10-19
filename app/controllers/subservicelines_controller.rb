class SubservicelinesController < ApplicationController
  # GET /subservicelines
  # GET /subservicelines.json
  def index
    if params[:psl]
      @subservicelines = Subserviceline.where(:productserviceline_id=>params[:psl])
    end

    if params[:sc]
      @ssl_id = Summarycommitment.where(:id=>params[:sc]).select(:subserviceline_id)
      @subservicelines = Subserviceline.where(:id=>@ssl_id)
    end

    if params[:ci]
      @sc_id = Commitmentitem.where(:id=>params[:ci]).first.summarycommitment_id
      @ssl_id = Summarycommitment.where(:id=>@sc_id).first.subserviceline_id
      @subservicelines = Subserviceline.where(:id=>@ssl_id)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subservicelines }
    end
  end

  # GET /subservicelines/1
  # GET /subservicelines/1.json
  def show
    @subserviceline = Subserviceline.find(params[:id])

    #render :layout => false
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subserviceline }
    end
  end

  # GET /subservicelines/new
  # GET /subservicelines/new.json
  def new(layout='true')
    
    @subserviceline = Subserviceline.new(:productserviceline_id => params[:productserviceline_id],
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

  # GET /subservicelines/1/edit
  def edit
    @subserviceline = Subserviceline.find(params[:id])
    @layout = params[:layout]

    if @layout='false'
      render :layout => false
    end
  end

  # POST /subservicelines
  # POST /subservicelines.json
  def create
    @subserviceline = current_user.subservicelines.new(params[:subserviceline])

    respond_to do |format|
      if @subserviceline.save

        @productserviceline = @subserviceline.productserviceline

        @updatetree = UpdateTree.new(current_user, @productserviceline, @subserviceline, nil, nil, "ssl", "update", params)  
        @updatetree.update_tree_instances


        format.html { redirect_to @subserviceline, notice: 'Subserviceline was successfully created.' }
        format.json { render json: @subserviceline, status: :created, location: @subserviceline }
      else
        format.html { render action: "new" }
        format.json { render json: @subserviceline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subservicelines/1
  # PUT /subservicelines/1.json
  def update
    @subserviceline = Subserviceline.find(params[:id])
    @subserviceline.user = current_user
    respond_to do |format|
      if @subserviceline.update_attributes(params[:subserviceline])
        
        @productserviceline = @subserviceline.productserviceline

        @updatetree = UpdateTree.new(current_user, @productserviceline, @subserviceline, nil, nil, "ssl", "update", params)  
        @updatetree.update_tree_instances

        format.html { redirect_to @subserviceline, notice: 'Subserviceline was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subserviceline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subservicelines/1
  # DELETE /subservicelines/1.json
  def destroy
    @subserviceline = Subserviceline.find(params[:id])
    @subserviceline.destroy

    respond_to do |format|
      format.html { redirect_to productservicelines_url }
      format.json { head :no_content }
    end
  end

  private

  def build
    @subserviceline.summarycommitments.build do |builder|
        builder.commitmentitems.build
      end 
  end

end
