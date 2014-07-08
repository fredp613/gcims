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

  def program_specific

    @application = Application.find(params[:app_id])
    @customtemplate = Customtemplate.find(params[:ct_id])
    # @ps = Applicationcustomtemplate.new
    if @customtemplate.for_application(@application, @customtemplate).blank?
      # @ps = Cict.programspecifictemplate(@application.commitmentitem_id)      
      @ps = Customtemplate.find(params[:ct_id])
    else
      # @ps = @application.applicationcustomtemplates.first.customfieldvalues
      @ps = @customtemplate.for_application(@application, @customtemplate).customfieldvalues
    end


     # if @wizard.customfieldvalues.blank?
     #    @eligibility = Cict.eligibilitytemplate(@wizard.commitmentitem_id)
     #  else
     #    @eligibility = @wizard.wizardcustomtemplates.first.customfieldvalues
     #  end

  end

  def submit_program_specific

     @application = Application.find(params[:application][:id])

    # if params[:save]
      respond_to do |format|
        # if @application.valid? 
          @application.update_attributes(params[:application])
          format.html { redirect_to project_path(:id=>@application.project), notice: "Application updated!" }
          format.json { render :show, status: :ok, location: @customtemplate }       
        # else
        #   format.html { render :program_specific }
        #   format.json { render json: @applicationcustomtemplate.errors, status: :unprocessable_entity }
        # end
      # end
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
