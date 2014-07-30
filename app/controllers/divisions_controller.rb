class DivisionsController < ApplicationController
  # GET /divisions
  # GET /divisions.json
  def index
    @divisions = Division.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @divisions }
    end
  end

  # GET /divisions/1
  # GET /divisions/1.json
  def show
    @division = Division.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @division }
    end
  end

  # GET /divisions/new
  # GET /divisions/new.json
  def new
    @division = Division.new

    if params[:client_id]
      @division.client_id = params[:client_id]
    end

    if params[:name]
      @division.name = params[:name]
    end

    if params[:name1]
      @division.name1 = params[:name1]
    end

    if params[:name2]
      @division.name2 = params[:name2]
    end

    if params[:state]
      @division.state = "new address"
      @division.build_location
    end

    @filter = LocationFilter.new(@division.client_id)
    @locations = @filter.location


    respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @division}
        format.js
        
    end
  end

  # GET /divisions/1/edit
  def edit
    @division = Division.find(params[:id])

    if !@division.location_id
      @division.build_location
    end

    @filter = LocationFilter.new(@division.client_id)
    @locations = @filter.location

    respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @division}
        format.js
        
    end

  end

  # POST /divisions
  # POST /divisions.json
  def create
    @division = Division.new(params[:division])

    if params[:new_address]

        respond_to do |format|
          format.html {redirect_to new_client_division_path(:client_id=>@division.client_id, 
              :name=>@division.name, 
              :name1=>@division.name1,
              :name2=>@division.name2,
              :state=>"new_address")}
          format.json { render json: @division, status: :created, location: @division}
          format.js
        end                
    else

      if params[:cancel]
        redirect_to client_path(@division.client_id)
      end

      respond_to do |format|
        
        if @division.save!
           if params[:new_address]         
            format.html { redirect_to edit_client_division_path(@division.client_id, @division), notice: 'Division was successfully created.' }
          else
            @division.update_attribute(:state, "completed")          
            format.html { redirect_to client_path(@division.client_id), notice: 'Division was successfully created.' }
          end
          format.js
          format.json { render json: @division, status: :created, location: @division }
        else
          @division.client_id = params[:division][:client_id]
          format.html { render action: "new" }
          format.json { render json: @division.errors, status: :unprocessable_entity }
          format.js
        end
      end
    end
  end

  # PUT /divisions/1
  # PUT /divisions/1.json
  def update
    @division = Division.find(params[:id])

    if params[:new_address] || @division.state == "new_address"
      @division.state = "new_address" 
      if @division.location_id != nil
        session[:location_id] = @division.location_id     
      end              
    end

    if params[:cancel]
      if @division.location_id == nil
        @division.update_attribute(:location_id, session[:location_id])
        session.delete(:location_id)
      end
      @division.update_attribute(:state, 'completed')
      redirect_to client_path(@division.client_id)
    else
      respond_to do |format|
        if @division.update_attributes(params[:division])
          if params[:new_address] 
            if @division.location_id != nil
              @division.update_attribute(:location_id, nil)
            end   
            format.html { redirect_to edit_client_division_path(@division.client, @division), notice: 'Division was successfully created.' }
          else
            @division.update_attribute(:state, "completed") 
            format.html { redirect_to client_path(@division.client), notice: 'Division was successfully updated.' }
            format.js
          end
          format.json { head :no_content }
          format.js

        else
          format.html { render action: "edit" }
          format.json { render json: @division.errors, status: :unprocessable_entity }
          format.js
        end
      end
    end
  end

  # DELETE /divisions/1
  # DELETE /divisions/1.json
  def destroy
    @division = Division.find(params[:id])
    @division.destroy

    respond_to do |format|
      format.html { redirect_to divisions_url }
      format.json { head :no_content }
    end
  end
end
