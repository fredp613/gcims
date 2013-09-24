class FincodesController < ApplicationController
  def index
  	@pras = Fincode.all
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pras }
    end

  end

# GET /Fincodes/1
  # GET /Fincodes/1.json
  def show
    @fincode = Fincode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fincode }
    end
  end

  # GET /Fincodes/new
  # GET /Fincodes/new.json
  def new
    @fincode = Fincode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fincode }
    end
  end

  # GET /Fincodes/1/edit
  def edit
    @fincode = Fincode.find(params[:id])
  end

  # POST /Fincodes
  # POST /Fincodes.json
  def create
    @fincode = Fincode.new(params[:fincode])

    respond_to do |format|
      if @fincode.save
        format.html { redirect_to @fincode, notice: 'Fincode was successfully created.' }
        format.json { render json: @fincode, status: :created, location: @fincode }
      else
        format.html { render action: "new" }
        format.json { render json: @fincode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /Fincodes/1
  # PUT /Fincodes/1.json
  def update
    @fincode = Fincode.find(params[:id])
    @fincode.user = current_user
    respond_to do |format|
      if @fincode.update_attributes(params[:fincode])
        format.html { redirect_to @fincode, notice: 'Fincode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fincode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Fincodes/1
  # DELETE /Fincodes/1.json
  def destroy
    @fincode = Fincode.find(params[:id])
    @fincode.destroy

    respond_to do |format|
      format.html { redirect_to Fincodes_url }
      format.json { head :no_content }
    end
  end


end
