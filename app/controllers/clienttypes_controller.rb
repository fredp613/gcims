class ClienttypesController < ApplicationController
  # GET /clienttypes
  # GET /clienttypes.json
  def index
    @clienttypes = Clienttype.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clienttypes }
    end
  end

  # GET /clienttypes/1
  # GET /clienttypes/1.json
  def show
    @clienttype = Clienttype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clienttype }
    end
  end

  # GET /clienttypes/new
  # GET /clienttypes/new.json
  def new
    @clienttype = Clienttype.new
    #@client = params[:client]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @clienttype }
    end
  end

  def new_client
    @clienttype = Clienttype.new
    
    if params[:client_id]
      @client = params[:client_id]
    #@country = params[:country_id]
    end

    if params[:country_id]
      @country = params[:country_id]
    else
      @country = 38
    end

    respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @clienttype}
        format.js
        
    end

  end

  def new_client_go
    
    @clienttype = Clienttype.new(params[:clienttype])
    
   
    

     respond_to do |format|
      if @clienttype.valid? 
        if !@clienttype.client.blank?
          format.html { redirect_to edit_client_path(:id=>@client, :clienttype_id=>@clienttype.name) }          
        else
          #@client = Client.find(26)
          format.html { redirect_to new_client_path(:clienttype_id=> @clienttype.name, :country_id=>params[:country_id])}          
        end
          
          @client = Client.new    
          @client.clienttype_id = @clienttype.name 
          @client.locations.build.build_clientlocation    
          @client.build_corporation
          @client.build_charity
          @client.build_band
          @client.emails.build
          @client.websites.build
          @client.country_id = 38
          @client.phones.build
          @remote=true

          format.json { render json: @clienttype, status: :created, location: @clienttype }
          format.js
          
      else
        format.html { render action: "new_client" }
        format.json { render json: @clienttype.errors, status: :unprocessable_entity }
        format.js
        
      end
    end


  end

  

  # GET /clienttypes/1/edit
  def edit
    @clienttype = Clienttype.find(params[:id])
  end

  # POST /clienttypes
  # POST /clienttypes.json
  def create
    @clienttype = Clienttype.new(params[:clienttype])
   

    respond_to do |format|
      if @clienttype.save
        format.html { redirect_to @clienttype }
        format.json { render json: @clienttype, status: :created, location: @clienttype }
      else
        format.html { render action: "new" }
        format.json { render json: @clienttype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clienttypes/1
  # PUT /clienttypes/1.json
  def update
    @clienttype = Clienttype.find(params[:id])

    respond_to do |format|
      if @clienttype.update_attributes(params[:clienttype])
        format.html { redirect_to @clienttype }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @clienttype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clienttypes/1
  # DELETE /clienttypes/1.json
  def destroy
    @clienttype = Clienttype.find(params[:id])
    @clienttype.destroy

    respond_to do |format|
      format.html { redirect_to clienttypes_url }
      format.json { head :no_content }
    end
  end

  def build_client
    
  end

end
