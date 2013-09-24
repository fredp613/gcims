class ContactlocationsController < ApplicationController
  # GET /contacttypes
  # GET /contacttypes.json
  def index
    @contactlocations = Contactlocations.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contactlocations }
    end
  end

  # GET /contacttypes/1
  # GET /contacttypes/1.json
  def show
    @contactlocation = Contactlocation.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contactlocation }
    end
  end

  # GET /contactlocations/new
  # GET /contactlocations/new.json
  def new
    @contactlocation = Contactlocation.new
    
    if params[:contact_id]
    @contact = params[:contact_id]
    end

    if params[:project_id]
    @project = params[:project_id]
    end

    @name = Contact.where(:id=>@contact).select(:lastname)
    
    if params[:client_id]
    @client = params[:client_id]
    else
    @client = Contact.where(:id=>@contact).first.client_id
    end

    @filter = LocationFilter.new(@client,@contact)
    @location = @filter.location 

    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contactlocation }
    end
  end

  # GET /contactlocations/1/edit
  def edit
    @contactlocation = Contactlocation.find(params[:id])
    @contact = params[:contact_id]
    @client = Contact.where(:id=>@contact).select(:client_id)
  end

  # POST /contactlocations
  # POST /contactlocations.json
  def create
    @contactlocation = Contactlocation.new(params[:contactlocation])
    
    respond_to do |format|
      if @contactlocation.save
        @contact = @contactlocation.contact_id
        
        if params[:project_id]
          @project = params[:project_id]
          #Projectcontact.create!(:project_id=>@project, :contact_id=>@contact)
          format.html { redirect_to edit_project_path(@project), notice: 'contacts location was successfully created.' }
        elsif params[:client_id]
          @client = params[:client_id]
          format.html { redirect_to edit_client_contact_path(@client, @contact), notice: 'contacts location was successfully created.' }
        end
        format.json { render json: @contactlocation, status: :created, location: @contactlocation }
      else
        format.html { render action: "new" }
        format.json { render json: @contactlocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contactlocations/1
  # PUT /contactlocations/1.json
  def update
    @contactlocation = Contactlocation.find(params[:id])
    @contact = @contactlocation.contact_id
     @client = @contact.client_id

    respond_to do |format|
      if @contactlocation.update_attributes(params[:contactlocation])
        format.html { redirect_to client_path(@client), notice: 'contactlocation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contactlocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contactlocations/1
  # DELETE /contactlocations/1.json
  def destroy
    @contactlocation = Contactlocation.find(params[:id])
    @location = @contactlocation.location_id
    @contact = @contactlocation.contact_id
    @locations = Contactlocation.where(:location_id=>@location).count
    
    if @locations <= 1 
      if Clientlocation.where(:location_id=>@location).blank?
          @contactlocation.location.destroy  
      end
    end

    @contactlocation.destroy

    respond_to do |format|
      format.html { redirect_to edit_contact_path(@contact)}
      format.json { head :no_content }
    end
  end
end
