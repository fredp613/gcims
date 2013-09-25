class ProjectsController < ApplicationController
  
  before_filter :authenticate_user!


  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json

  def new
    @project = Project.new
    @project.client_id = params[:client_id]
    @project.applications.build

    @token = (0...50).map{ ('a'..'z').to_a[rand(26)] }.join
    @stale_form_ts = Time.now.to_i

    if params[:new]
      session[:new] = true
    end

    if params[:client_id]
      @client_id = params[:client_id]
      @client_name = Client.where(:id=>@client_id).first.name
    end




    respond_to do |format|
        if params[:layout]
          format.html { render :layout => false }
        else
          format.html # show.html.erb
        end
        format.json { render json: @project}
        
    end
    

  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    @mainapplication = Application.where(:project_id=>@project).first
    @contacts = Contact.where(:client_id=>@project.client_id)
    @existing = Contact.joins(:projectcontacts).where("projectcontacts.project_id = ?", @project )
    @contacts_clean = @contacts.map(&:id) - @existing.map(&:id)
    @ddl = Contact.where(:id=>@contacts_clean)
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    @client_id = params[:client_id]
    @project.client_id = @client_id

    #if session[:last_created_at].to_i > params[:ts].to_i
    #  @existing_project = Project.where(:token=>@project.token).first
    #  redirect_to edit_project_path(@existing_project)
    #else

    respond_to do |format|
      if @project.save
        @state_form_ts = Time.now.to_i
        session[:last_created_at] = @state_form_ts
        if !session[:new]
          format.html { redirect_to @project, notice: 'Project was successfully created.' }
        else
          format.html { redirect_to edit_project_path(@project), notice: 'Project was successfully created.' }
        end
        format.json { render json: @project, status: :created, location: @project }
        format.js {render :js => "window.location = '#{edit_project_path(@project)}'" } 

      else
       # @state_form_ts = Time.now.to_i
        #session[:last_created_at] = @state_form_ts
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

    respond_to do |format|
      if @project.update_attributes(params[:project])
        if params[:pras]
         format.html { redirect_to edit_application_path(@project.applications.first, :pras=>true) }
        else
         format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
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



  private

  def build
    @project.projectcontacts.build
  end






end







