class ClientlocationsController < ApplicationController
  # GET /clienttypes
  # GET /clienttypes.json
  def index
    @clientlocations = Clientlocations.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clientlocations }
    end
  end

  # GET /clienttypes/1
  # GET /clienttypes/1.json
  def show
    @clientlocation = Clientlocation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clientlocation }
    end
  end

  # GET /clientlocations/new
  # GET /clientlocations/new.json
  def new
    @clientlocation = Clientlocation.new
    @client = params[:client]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @clientlocation }
    end
  end

  # GET /clientlocations/1/edit
  def edit
    @clientlocation = Clientlocation.find(params[:id])
    @client = params[:client]
  end

  # POST /clientlocations
  # POST /clientlocations.json
  def create
    @clientlocation = Clientlocation.new(params[:clientlocation])
    @client = @clientlocation.client_id

    respond_to do |format|
      if @clientlocation.save
        format.html { redirect_to client_path(@client), notice: 'clientlocation was successfully created.' }
        format.json { render json: @clientlocation, status: :created, location: @clientlocation }
      else
        format.html { render action: "new" }
        format.json { render json: @clientlocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clientlocations/1
  # PUT /clientlocations/1.json
  def update
    @clientlocation = Clientlocation.find(params[:id])
    @client = @clientlocation.client_id

    respond_to do |format|
      if @clientlocation.update_attributes(params[:clientlocation])
        format.html { redirect_to client_path(@client), notice: 'clientlocation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @clientlocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientlocations/1
  # DELETE /clientlocations/1.json
  def destroy
    @clientlocation = Clientlocation.find(params[:id])
    @client = @clientlocation.client_id
    @clientlocation.destroy

    redirect_to :back
    #respond_to do |format|
    #  format.html { redirect_to client_path(@client) }
    #  format.json { head :no_content }
    #end
  end
end
