class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json

  
  def new
    #reset_session
    @location = Location.new
    build
    
    if params[:client_id]
      @client = params[:client_id]
    end

    if params[:contact_id]
      @contact = params[:contact_id]
      @client = Contact.where(:id=>@contact).first.client_id
    end

    if params[:country_id]
      @country_id = params[:country_id]
    else
      @country_id = 38
    end

    if params[:project_id]
      @project = params[:project_id]
      #session[:project] = @project
    end
    
    filter_type

    respond_to do |format|
        format.html
        format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    session[:return_to] ||= request.referer
    @location = Location.find(params[:id])
    
    if params[:edit]
      @edit = true
    end

    if params[:client_id]
      @client = params[:client_id]
      #session[:client] = @client
    end

    if params[:contact_id]
      @contact = params[:contact_id]
      #session[:contact] = @contact
    end

    if params[:country_id]
      @country_id = params[:country_id]
    else
      @country_id = @location.country_id
    end

    filter_type
   
    
  end

  # POST /locations
  # POST /locations.json
   def create
    @location = Location.new(params[:location])
    
    

    if params[:client_id]
      @client = params[:client_id]
      #session[:client] = @client
    end

    if !params[:location][:contactlocations_attributes].blank?
      params[:location][:contactlocations_attributes].values.each do |contact|
       @contact = contact[:contact_id]
       #session[:contact] = @contact
      end
    end

    if params[:project_id]
      @project = params[:project_id]
      @contact = params[:contact_id]
    end

    if params[:country]   
      
      if @contact 
        if @client && !@project
        redirect_to foreign_locations_path(:client_id=>@client, :contact=>@contact)
        end

        if @project && @client 
        redirect_to foreign_locations_path(:project_id=>@project, :contact=>@contact)
        end
      else
        if @client 
        redirect_to foreign_locations_path(:client_id=>@client)
        end

        if @project 
        redirect_to foreign_locations_path(:project_id=>@project)
        end
      end

    else 

      respond_to do |format|
        if @location.save    
          if @contact 
            if @client && @contact && !@project
            format.html { redirect_to edit_client_contact_path(@client, @contact) , notice: 'Location was successfully created.' } 
            elsif @project && @contact && @client

            format.html { redirect_to edit_project_path(@project) , notice: 'Location was successfully created.' } 
            else
            format.html { redirect_to edit_contact_path(@contact) , notice: 'Location was successfully created.' }   
            end
          else
            if @client && !@project 
            format.html { redirect_to client_path(@client) , notice: 'Location was successfully created.' } 
            else #project
            format.html { redirect_to edit_project_path(@project) , notice: 'Location was successfully created.' } 
            end
          end

            format.json { render json: @location, status: :created, location: @location }

        else
          format.html { render action: "new" }
          format.json { render json: @location.errors, status: :unprocessable_entity }
        end
      end
      
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

      #if !params[:location][:clientlocations_attributes].blank?
      #   @client = @location.clientlocations.first.client_id
      #end

      if params[:client_id]
        @client = params[:client_id]
      end

      if params[:contact_id]
         @contact = params[:contact_id]
      end

      if params[:project_id]
        @project = params[:project_id]
      end

    if params[:country]
      
      if @contact 
        if @client 
        redirect_to foreign_locations_path(:id=>@location, :client_id=>@client, :contact=>@contact)
        end

        if @project
        redirect_to foreign_locations_path(:id=>@location, :project_id=>@project, :contact=>@contact)
        end
      else
        if @client 
        redirect_to foreign_locations_path(:id=>@location, :client_id=>@client)
        end

        if @project
        redirect_to foreign_locations_path(:id=>@location, :project_id=>@project)
        end
      end

    else  
      respond_to do |format|
        if @location.update_attributes(params[:location])

          if @client && !@contact && !@project
            format.html { redirect_to client_path(@client) , notice: 'Location was successfully updated.' }
          elsif @contact && @client && !@project        
             format.html { redirect_to edit_client_contact_path(@client, @contact), notice: 'Location was successfully updated.' }
          elsif @project
            format.html { redirect_to edit_project_contact_path(@project, @contact), notice: 'Location was successfully updated.' }

          end
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @location.errors, status: :unprocessable_entity }
        end
      end
   end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @client = Client.find(@location.client_ids)
    @contact = Contact.find(@location.contact_ids)
    
    @location.destroy

    respond_to do |format|
      
      format.html { redirect_to request.referer }
      format.json { head :no_content }
    end
  end

  #custom routes
  def foreign
    if params[:id]
      @location = Location.find(params[:id])
    else
      @location = Location.new
    end

    if params[:project_id]
      @project = params[:project_id]
    end

    if params[:client_id]
      @client = params[:client_id]
      
    end


    if params[:contact] 
    @contact = params[:contact]      
    end
  end

  def foreign_go
     @country = params[:country_id]
     
     if params[:location_id]
      @location = params[:location_id]
     end

     if params[:project_id]
      @project = params[:project_id]
     end

     if params[:client_id]
      @client = params[:client_id]
     end

     if params[:contact_id]
      @contact = params[:contact_id]
     end

     if @location #we are in edit mode
        if @project 
          redirect_to edit_project_contact_location_path(@project, @contact, @location,:country_id=>@country)
        elsif @client && !@contact
          redirect_to edit_client_location_path(@client, @location,:country_id=>@country)
        elsif @contact && @client && !@project
          redirect_to edit_client_contact_location_path(@client, @contact, @location, :country_id=>@country)
        end
     else
        if @project
            redirect_to new_project_contact_location_path(@project, @contact, :country_id=>@country)
        elsif @client && !@contact
          redirect_to new_client_location_path(@client,:country_id=>@country)
        elsif @contact && @client && !@project
          redirect_to new_client_contact_location_path(@client, @contact, :country_id=>@country)
          end
     end
   
  end


  private

  def build
     @location.clientlocations.build
     @location.contactlocations.build
  end

  def filter_type  
    if params[:client_id]
     # @client = params[:client]
      @newrecord = Clientlocation.where(:Location_id=>@location.id).first
      @check_for_primary = Clientlocation.where(:client_id=>@client, :addresstype_id=>1)
      if  !@newrecord.blank?
        @check_current_primary = Clientlocation.where(:client_id=>@client, :Location_id=>@location.id).first
        @primarycheck = @check_current_primary.addresstype_id
      else
        @primarycheck = 0
      end

    #elsif params[:contact]
     # @contact=params[:contact]
     #  @newrecord = Contactlocation.where(:Location_id=>@location.id).first
     #  if !Contactlocation.where(:contact_id=>@contact).blank?
     #  @check_for_primary = Contactlocation.where(:contact_id=>@contact, :addresstype_id=>1)
     #  end
     # if  !@newrecord.blank?
     #   @check_current_primary = Contactlocation.where(:contact_id=>@contact)
     #   @primarycheck = @check_current_primary.first.addresstype_id
     # else
     #   @primarycheck = 0
     # end
    end
  end



end