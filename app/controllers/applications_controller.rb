class ApplicationsController < ApplicationController
  # GET /applications
  # GET /applications.json
  def index
    @applications = Application.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
    @application = Application.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @application }
    end
  end

  # GET /applications/new
  # GET /applications/new.json
  def new
    @application = Application.new

    respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @application}
        format.js
        
    end
  end

 

  # GET /applications/1/edit
  def edit
    @application = Application.find(params[:id])

    if params[:pras]
      session[:pras] = true
    end

    if params[:updating_unique_attribute]      
      @application.updating_unique_attribute = params[:updating_unique_attribute]
    end

    respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @application}
        format.js
        
    end
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(params[:application])
    @application.created_by = current_user.id
    @application.updated_by = current_user.id

    @updating_unique_attribute = true

    respond_to do |format|
      if @application.save
        @project = Project.find(@application.project_id)
        format.html { redirect_to @application, notice: 'Application was successfully created.' }
        format.json { render json: @application, status: :created, location: @application }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /applications/1
  # PUT /applications/1.json
  def update
    @application = Application.find(params[:id])
    @application.updated_by = current_user
    
    if params[:updating_unique_attribute]      
      @application.updating_unique_attribute = self
    end
    

    respond_to do |format|
      if @application.update_attributes(params[:application])
        @project = Project.find(@application.project_id)
        if session[:pras] || @application.updating_unique_attribute.present?
          format.html { redirect_to project_path(@application.project), notice: 'Application was successfully updated.' }
        else
          format.html { redirect_to @application, notice: 'Application was successfully updated.' }
        end
        format.json { head :no_content }
        format.js
      else

        format.html { render action: "edit" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
        format.js
      end
    end
    
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    respond_to do |format|
      format.html { redirect_to applications_url }
      format.json { head :no_content }
      format.js
    end
  end


  def current_resource
    @current_resource ||= Application.find(params[:id]) if params[:id]
  end


end
