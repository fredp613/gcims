class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new
    
    if params[:client_id]
    @client = params[:client_id]
    end

    if params[:project_id]
    @project = params[:project_id]
    @client = Project.where(:id=>@project).first.client_id
    end

    build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
    
    if params[:client_id]
    @client = params[:client_id]
    else
    @client = @contact.client_id
    end
    if params[:project_id]
      @project = params[:project_id]
    end

    

    @location_filter = LocationFilter.new(@client, @contact.id)
    @location = @location_filter.location 
 
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(params[:contact])
    if params[:client_id]
    @client = params[:client_id]
    end

    if params[:project_id]
    @project = params[:project_id]
    end
   

    respond_to do |format|
      if @contact.save
         if params[:client_id] && !params[:project_id] 
         format.html { redirect_to new_client_contactlocation_path(@client, :contact_id=>@contact), notice: 'Add address information.' }
         elsif params[:project_id] 
          Projectcontact.create!(:contact_id=>@contact.id, :project_id=>@project)
         format.html { redirect_to new_project_contactlocation_path(@project, :contact_id=>@contact), notice: 'Add address information1.' }
         end
         format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])
    if params[:project_id]
      @project = params[:project_id]
    end

    if params[:client_id]
      @client = params[:client_id]
    end

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        if params[:project_id]
        format.html { redirect_to project_path(@project), notice: 'Contact was successfully added.' }
        else
        format.html { redirect_to client_path(@client), notice: 'Contact was successfully updated.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @client = @contact.client_id


    @contact.locations.each do |location|
      @locations = Contactlocation.where(:location_id=>location).count
      if @locations <= 1 
        if Clientlocation.where(:location_id=>location).blank?
            location.destroy  
        end
      end
    end
    
    @contact.destroy

    
    respond_to do |format|
      format.html { redirect_to client_path(@client) }
      format.json { head :no_content }
    end
  end

  def build 
    @contact.locations.build
    @contact.contactlocations.build
  end


end
