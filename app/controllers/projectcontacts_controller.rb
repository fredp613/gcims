class ProjectcontactsController < ApplicationController
  # GET /projectcontacts
  # GET /projectcontacts.json
  def index
    @projectcontacts = Projectcontact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projectcontacts }
    end
  end

  # GET /projectcontacts/1
  # GET /projectcontacts/1.json
  def show
    @projectcontact = Projectcontact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @projectcontact }
    end
  end

  # GET /projectcontacts/new
  # GET /projectcontacts/new.json
  def new
    @projectcontact = Projectcontact.new
    
    @project = params[:project_id]
    @client = Project.where(:id=>@project).select(:client_id)
    @contacts = Contact.where(:client_id=>@client)
    @existing = Contact.joins(:projectcontacts).where("projectcontacts.project_id = ?", @project )
    @contacts_clean = @contacts.map(&:id) - @existing.map(&:id)
    @ddl = Contact.where(:id=>@contacts_clean)

   
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @projectcontact }
    end
  end

  # GET /projectcontacts/1/edit
  def edit
 
      @projectcontact = Projectcontact.find(params[:id])
 
  end

  # POST /projectcontacts
  # POST /projectcontacts.json
  def create
    @projectcontact = Projectcontact.new(params[:projectcontact])
    #@project = params[:project]
    #@contacts = params[:contact_ids]

    #@contacts.each do |c| 
    #  Projectcontact.create!(:contact_id=>5, :project_id=>params[:project])
    #end
    #redirect_to edit_project_path(@project)


    respond_to do |format|
      if @projectcontact.save
        format.html { redirect_to project_path(@projectcontact.project_id), notice: 'Contacttype was successfully created.' }
        format.json { render json: @projectcontact, status: :created, location: @projectcontact }
      else
        format.html { render action: "new" }
        format.json { render json: @projectcontact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projectcontacts/1
  # PUT /projectcontacts/1.json
  def update
    @projectcontact = Projectcontact.find(params[:id])

    respond_to do |format|
      if @projectcontact.update_attributes(params[:projectcontact])
        format.html { redirect_to @projectcontact, notice: 'Projectcontact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @projectcontact.errors, status: :unprocessable_entity }
      end
    end
  end

  

  # DELETE /projectcontacts/1
  # DELETE /projectcontacts/1.json
  def destroy
    @projectcontact = Projectcontact.find(params[:id])
    @project = @projectcontact.project_id
    @projectcontact.destroy

    respond_to do |format|
      format.html { redirect_to edit_project_path(@project) }
      format.json { head :no_content }
    end
  end
end
