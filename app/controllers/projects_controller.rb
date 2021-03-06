class ProjectsController < ApplicationController
  
  before_filter :set_instance_variables, only: [:new, :create]
  before_filter :set_show_variables, only: [:show, :edit]
  # caches_page :show


  def index
    @projects = Project.where(:created_by=>current_user.id)

    if params[:projects_page_size]  
     @project_page_size = params[:projects_page_size]
      else
     @project_page_size = 10
    end
    
    if params[:search_field]
      @query = params[:search_field]
    else
      @query = "" 
    end

    if params[:reset]
      @query = ""
    end

    @projects_search = @projects.text_search(@query).to_a 

    @total_applications = Application.where(:project_id=>@projects_search)
    @applications = Application.joins(:commitmentitem => :summarycommitment).where(:project_id=>@projects_search).page(params[:project_page]).per(@project_page_size)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
      format.js
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
      format.js { render "show" }
    end
  end

  # GET /projects/new
  # GET /projects/new.json

  def new
    @project = Project.new
    #@project.client_id = params[:client_id]
    @project.applications.build
    @project.client_id = params[:client_id]

    @token = (0...50).map{ ('a'..'z').to_a[rand(26)] }.join
    @stale_form_ts = Time.now.to_i

    if params[:new]
      session[:new] = true
    end
      
    respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @project}
        format.js        
    end
    

  end

  def eligibility 
    
  respond_to do |format|
    format.json { render json: @eligibility}
    format.js
  end

  end

  # GET /projects/1/edit
  def edit


    if params[:updating_unique_attribute]      
      @project.updating_unique_attribute = params[:updating_unique_attribute]
    end

    @eligibility_template = true

     respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @project}
        format.js
        
    end
    
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    @project.created_by = current_user.id
    @project.updated_by = current_user.id
    
    
    @client_id = params[:client_id]
    @project.client_id = @client_id
    #@project.division_id = params[:project][:division_id]

    #if session[:last_created_at].to_i > params[:ts].to_i
    #  @existing_project = Project.where(:token=>@project.token).first
    #  redirect_to edit_project_path(@existing_project)
    #else

    respond_to do |format|
      if @project.save
        
        flash[:notice] = "Project was successfully created."
        @state_form_ts = Time.now.to_i
        session[:last_created_at] = @state_form_ts
        format.html { redirect_to project_path(@project) }        
        format.json { render json: @project, status: :created, location: @project  }
        format.js  

      else
       # @project.division_id = 2
       # @state_form_ts = Time.now.to_i
        #session[:last_created_at] = @state_form_ts
        #@client_name = Client.where(:id=>@client_id).first.name      
        #@province = Client.where(:id=>params[:client_id]).first.clienttype_id
        format.html { render action: "new"  }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.js 
      end
    end
    #end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    

    @project = Project.find(params[:id])
    @project.updated_by = current_user#.id

        respond_to do |format|
          if @project.update_attributes(params[:project])
            flash[:notice] = "Project was successfully updated."
            if params[:pras]
             format.html { redirect_to edit_application_path(@project.applications.first, :pras=>true) }                
            else             
             format.html { redirect_to project_path(@project)}             
            end
            format.json { head :no_content }
            format.js
          else
            format.html { render action: "edit" }
            format.json { render json: @project.errors, status: :unprocessable_entity }
            format.js
          end
        end

    
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  #custom actions
  def current_resource
    @current_resource ||= Project.find(params[:id]) if params[:id]
  end

  private

  def build
    @project.projectcontacts.build
  end

  def set_instance_variables    
    @client_name = Client.where(:id=>params[:client_id]).first.name      
    @province = Client.where(:id=>params[:client_id]).first.clienttype_id
  end

  def set_show_variables
    @project = Project.find(params[:id])

    @mainapplication = @project.applications.first
    @contacts = Contact.where(:client_id=>@project.client_id)
    @existing = Contact.joins(:projectcontact).where("projectcontacts.project_id = ?", @project )
    @contacts_clean = @contacts.map(&:id) - @existing.map(&:id)
    @ddl = Contact.where(:id=>@contacts_clean)

    @total_estimate = @project.budgetitems.this_funder.sum(:forecast)
    @total_actual = @project.budgetitems.this_funder.sum(:actual)

    @total_estimate_other = @project.budgetitems.other_funder.sum(:forecast)
    @total_actual_other = @project.budgetitems.other_funder.sum(:actual)
  end










end







