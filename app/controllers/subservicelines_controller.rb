class SubservicelinesController < ApplicationController
  # GET /subservicelines
  # GET /subservicelines.json
  def index

#for ajax cal
    if params[:psl]
      @subservicelines = Subserviceline.active.where(:productserviceline_id=>params[:psl])
    end

    if params[:sc]
      @ssl_id = Summarycommitment.active.where(:id=>params[:sc]).select(:subserviceline_id)
      @subservicelines = Subserviceline.active.where(:id=>@ssl_id)
    end

    if params[:ci]
      @sc_id = Commitmentitem.active.where(:id=>params[:ci]).first.summarycommitment_id
      @ssl_id = Summarycommitment.active.where(:id=>@sc_id).first.subserviceline_id
      @subservicelines = Subserviceline.active.where(:id=>@ssl_id)
    end
 ##########
    # @subservicelines = Subserviceline.all

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
  def new
    
    @subserviceline = Subserviceline.new(:productserviceline_id => params[:productserviceline_id],
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

  # GET /subservicelines/1/edit
  def edit
    @subserviceline = Subserviceline.find(params[:id])
    
    if params[:layout]
      render :layout => false
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @subserviceline }
      end
    end
  end

  # POST /subservicelines
  # POST /subservicelines.json
  def create
    @subserviceline = current_user.subservicelines.new(params[:subserviceline])
    
    respond_to do |format|
      if @subserviceline.save
<<<<<<< HEAD

        @productserviceline = @subserviceline.productserviceline

        @updatetree = UpdateTree.new(current_user, @productserviceline, @subserviceline, nil, nil, "ssl", "update", params)  
        @updatetree.update_tree_instances


        format.html { redirect_to subserviceline_path(@subserviceline), notice: 'Subserviceline was successfully created.' }
=======
        @productservicelines = Productserviceline.all
        format.html { redirect_to productservicelines_path, notice: 'Subserviceline was successfully created.' }
>>>>>>> fy_refactor
        format.json { render json: @subserviceline, status: :created, location: @subserviceline }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @subserviceline.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /subservicelines/1
  # PUT /subservicelines/1.json
  def update
    @subserviceline = Subserviceline.find(params[:id])
    @subserviceline.user = current_user
    @productservicelines = Productserviceline.all    
    respond_to do |format|
      if @subserviceline.update_attributes(params[:subserviceline]) 

        @productservicelines = Productserviceline.all

        format.html { redirect_to productservicelines_path, notice: 'Subserviceline was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @subserviceline.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /subservicelines/1
  # DELETE /subservicelines/1.json
  def destroy
    @subserviceline = Subserviceline.find(params[:id])
    @subserviceline.destroy
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

  private

  def build
    @subserviceline.summarycommitments.build do |builder|
        builder.commitmentitems.build
      end 
  end

end
