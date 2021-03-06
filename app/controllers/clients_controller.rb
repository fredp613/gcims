class ClientsController < ApplicationController
  
  #before_filter :set_cache_buster, only:["new", "create"]
  
  before_filter :authenticate_user!
  before_filter :set_instance_variables, :only=>[:show, :edit]

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.order(:name)
    @provinces = State.where(:country_id=>38)
    @types = Clienttype.all 
    #reset_session
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    
    
    if !@client.corporation
      @client.build_corporation
    end

    if !@client.charity
      @client.build_charity
    end

    if !@client.band
      @client.build_band
    end


    #reset_session
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new

    @client = Client.new
    #@corporation = Corporation.new  
    
    @client.token = (0...50).map{ ('a'..'z').to_a[rand(26)] }.join
    
      if @client.clienttype_id.blank? && @remote != true
        @client.clienttype_id = params[:clienttype_id]
      else
        @client.clienttype_id = 3
      end
    
    
    if params[:country_id] && @remote != true #&& !params[:country_id].blank?
      @client.country_id = params[:country_id]
    else
      @client.country_id = 38
    end

    #@clienttype_display_name = Clienttype.where(:id=>@clienttype).first.name

    #session[:return_to] ||= request.referer
    build
    respond_to do |format|
        if params[:layout]

          @remote = true

          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @client}
        format.js
        
    end
  end

  

  # POST /clients
  # POST /clients.json
  def create
      @client = Client.new(params[:client])
      @client.created_by = current_user.id
      @client.updated_by = current_user.id

      if params[:client][:incorporated] == "1"
        @client.corporation.nested_from_client = 'yes'
      end

      if params[:client][:registeredcharity] == "1"
        @client.charity.nested_from_client = 'yes'
      end

      if params[:client][:registeredband] == "1"
        @client.band.nested_from_client = 'yes'
      end

          
    #if (session[:last_created_at].to_i > params[:ts].to_i) && !@client.errors.any?
      #@existing_client = Client.where(:token=>@client.token).first
     # redirect_to edit_client_path(@existing_client, :wizard=>true)
    #else
        if params[:country] || params[:clienttype] 
          if params[:country]
            session[:name] = @client.name
            session[:clienttype] = @client.clienttype_id
            
            respond_to do |format|
              format.html { redirect_to foreign_clients_path }
              format.js { render :js => "window.location = '#{foreign_clients_path}'" } 
            end
            
          else
            session[:name] = @client.name
            
            respond_to do |format|
              format.html { redirect_to new_client_clienttypes_path(:country_id=>params[:country_id]) }
              format.js { render :js => "window.location = '#{new_client_clienttypes_path(:country_id=>params[:country_id])}'" } 
            end

          end
        else
          respond_to do |format|
            if @client.save
              @state_form_ts = Time.now.to_i
              session[:last_created_at] = @state_form_ts
              #reset_session
              @nav = AdditionalInformationNav.new(@client)
              @step = @nav.nav

              if (@step == 'corporation' || @step == 'band' || @step == 'charity') && @client.clienttype_id !=1
                session[:step] = @client.steps.first
                format.html { redirect_to edit_client_path(@client, :wizard=>true) }
              else
                flash[:notice] = "Client was successfully created."
                format.html { redirect_to @client }
              #  reset_session
              end
              format.json { render json: @client, status: :created, location: @client }
              format.js { render :js => "window.location = '#{client_path(@client)}'" } 
              # session.delete(:clienttype)
            else
              @client.country_id = params[:country_id] ||= 38
              @client.clienttype_id = params[:client][:clienttype_id]

                if @client.websites.blank?
                  @client.websites.build
                end

                if @client.emails.blank?
                  @client.emails.build
                end

                if @client.phones.blank?
                  @client.phones.build
                end
              
              @remote = true
              format.html { render action: "new" }
              format.json { render json: @client.errors, status: :unprocessable_entity }
              format.js 
            end
          end
        end
    #end
  end

  # GET /clients/1/edit
  def edit
    


    if params[:clienttype_id]
      @client.clienttype_id = params[:clienttype_id]
    end
    

    @clienttype_display = Clienttype.where(:id=>@client.clienttype_id).first

    if params[:edit]
      @edit = true
    end

    if params[:mandate_only] 
      @mandate_only = true
    end

    if params[:step]
      @step = params[:step]
      session[:edit_only]
      if params[:edit]
        session[:edit] = true
      end
     
    end

    if params[:wizard]
        @client.current_step = session[:step]
        @wizard = true
      else
        session[:edit_only] = true
    end

    if !@client.band
      @client.build_band
    end

    if !@client.charity
      @client.build_charity
    end

    if !@client.corporation
      @client.build_corporation
    end
    if @client.charity.registrationdate
      @date = @client.charity.registrationdate
    else
      @date = ""
    end

    if params[:country_id]
      @client.country_id = params[:country_id]
    end

    
    #@clienttype = @client.clienttype_id

    @clienttype_from_change = params[:clienttype]
    @clienttype_from_change_display = Clienttype.where(:id=>@clienttype_from_change).first
    @back = session[:return_to] ||= request.referer

    respond_to do |format|
      format.html 
      format.json { render json: @client}
    end
    
    
  end


  # PUT /clients/1 
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])
    @client.updated_by = current_user.id
    
   
    if !session[:edit_only]
        @client.current_step = session[:step]

        #block the update action or change the logic in the model
        if params[:back_button]
            if @client.current_step == 'corporation'
              @new = true
            end
          @client.previous_step 
        else
          @client.next_step unless @client.last_step?

          if params[:last]
            session[:edit_only] = true
          end
          
        end

        session[:step] = @client.current_step
    end 

    respond_to do |format|
     if @client.update_attributes(params[:client])
      @nav = AdditionalInformationNav.new(@client)
      @step = @nav.nav
      
        flash.now[:notice] = 'Client changes saved'
      
        if !session[:edit_only]
          if @new
          format.html { redirect_to edit_client_path(@client) }
          else
            if params[:back_button]
              format.html { redirect_to edit_client_path(@client, :wizard=>true, :back_button=>true) }
            else
              format.html { redirect_to edit_client_path(@client, :wizard=>true) }
            end
          end
          format.json { head :no_content }
          format.js { render :js => "window.location = '#{client_path(@client)}'" }
          

         # if @last = true
          #  session[:edit_only] = true
          #end
          else
            if !session[:edit]
              flash.now[:notice] = "Client was successfully updated."
              format.html { redirect_to @client, notice: 'Client has been saved' }
            else 
              format.html { redirect_to edit_client_path(@client), notice: 'saved' }
              format.js                      
            end
        format.js          
        end
      #reset_session
     else
      #@nav = AdditionalInformationNav.new(@client)
      #@step = @nav.nav

      format.html { render action: "edit" }
      format.json { render json: @client.errors, status: :unprocessable_entity }
      format.js 
      end
    end

  end



   # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])

    @client.locations.each do |location|
       location.delete
    end

    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url}
      format.json { head :no_content }
    end
  end

  #custom routes
  def foreign
    if params[:client_id]
      @client_id = params[:client_id]
    end
      
    @client = Client.new
  end

  def foreign_go
    if !params[:client_id]
      redirect_to new_client_path(:country_id=>params[:country_id], :clienttype_id=>session[:clienttype], :name=>session[:name])
    else
      redirect_to edit_client_path(:id=>params[:client_id], :country_id=>params[:country_id])
    end
  end



  private

  def build
    @client.locations.build.build_clientlocation    
    @client.build_corporation
    @client.build_charity
    @client.build_band
    @client.emails.build
    @client.websites.build
    @client.phones.build
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def set_instance_variables
    @client = Client.find(params[:id])

  end



end
