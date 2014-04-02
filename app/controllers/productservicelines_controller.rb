class ProductservicelinesController < ApplicationController
  # GET /productservicelines
  # GET /productservicelines.json
  
  before_filter :authenticate_user!
  
  def index
    @fiscalyear1 = params[:fy1]
    @fiscalyear2 = params[:fy2]
    @fyArray = []

    if params[:startdate] && params[:enddate]
     # @productserviceline.startdate = params[:startdate]
     # @productserviceline.enddate = params[:enddate]
      @fy1 = params[:startdate].to_date
      @fy2 = params[:enddate].to_date
      @fys = FiscalYear.new(@fy1, @fy2).fiscalyear
    end

    @productservicelines = Productserviceline.all
    #@pslFiltered = Productserviceline.search(@fiscalyear1, @fiscalyear2)
    @fiscalyears = Fiscalyear.search(@fiscalyear1, @fiscalyear2).select(:id).to_a
    @fyArray = @fiscalyears.map{ |x| x[:id] }

    respond_to do |format|
      format.html 
      format.json { render json: @productservicelines }
    end
  end

  def pras_index

    if params[:ssl]
      @psl_id = Subserviceline.where(:id=>params[:ssl]).select(:productserviceline_id)
      @productservicelines =  Productserviceline.where(:id=>@psl_id)
    end

    if params[:sc]
      @ssl_id = Summarycommitment.where(:id=>params[:sc]).first.subserviceline_id
      @psl_id = Subserviceline.where(:id=>@ssl_id).select(:productserviceline_id)
      @productservicelines = Productserviceline.where(:id=>@psl_id)
    end

    if params[:ci]
      @sc_id = Commitmentitem.where(:id=>params[:ci]).first.summarycommitment_id
      @ssl_id = Summarycommitment.where(:id=>@sc_id).first.subserviceline_id
      @psl_id = Subserviceline.where(:id=>@ssl_id).select(:productserviceline_id)
      @productservicelines = Productserviceline.where(:id=>@psl_id)
    end


    respond_to do |format|
      format.html 
      format.json { render json: @productservicelines }
    end

  end

  # GET /productservicelines/1
  # GET /productservicelines/1.json
  def show
    @productserviceline = Productserviceline.find(params[:id])
  
      #render :layout => false
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @productserviceline }
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text "Hello World"
        send_data pdf.render
      end
    end
  end

  # GET /productservicelines/new
  # GET /productservicelines/new.json
  def new
    @layout = params[:layout]
    @productserviceline = Productserviceline.new
    build
   
    if @layout= "false"   
      render :layout => false
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @subserviceline }
      end
    end
  end

  # GET /productservicelines/1/edit
  def edit
    @productserviceline = Productserviceline.find(params[:id])

    @layout = params[:layout]

    if @layout='false'
      render :layout => false
    end
    
  end

  # POST /productservicelines
  # POST /productservicelines.json
  def create
    @productserviceline = current_user.productservicelines.new(params[:productserviceline])

    respond_to do |format|
      if @productserviceline.save
        @updatetree = UpdateTree.new(current_user, @productserviceline, nil, nil, nil, "psl", "update", params)  
        @updatetree.update_tree_instances
        
        format.html { redirect_to productserviceline_path(@productserviceline), notice: 'Productserviceline was successfully created.' }
        format.json { render json: @productserviceline, status: :created, location: @productserviceline }
      else
        format.html { render action: "new" }
        format.json { render json: @productserviceline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /productservicelines/1
  # PUT /productservicelines/1.json
  def update
    @productserviceline = Productserviceline.find(params[:id])
    @productserviceline.user = current_user

    respond_to do |format|
      if @productserviceline.update_attributes(params[:productserviceline]) 
        @updatetree = UpdateTree.new(current_user, @productserviceline, nil, nil, nil, "psl", "update", params)  
        @updatetree.update_tree_instances
  
        
        format.html { redirect_to @productserviceline, notice: 'Productserviceline was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @productserviceline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productservicelines/1
  # DELETE /productservicelines/1.json
  def destroy
    @productserviceline = Productserviceline.find(params[:id])
    @productserviceline.destroy

    respond_to do |format|
      format.html { redirect_to productservicelines_url }
      format.json { head :no_content }
    end
  end


  private

  def build
    @productserviceline.subservicelines.build do |builder|
        builder.summarycommitments.build.commitmentitems.build
      end 
  end

 

end
