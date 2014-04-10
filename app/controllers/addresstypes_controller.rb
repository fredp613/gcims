class AddresstypesController < ApplicationController
  # GET /addresstypes
  # GET /addresstypes.json
  before_filter :authenticate_user!
  def index
    @addresstypes = Addresstype.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @addresstypes }
    end
  end

  # GET /addresstypes/1
  # GET /addresstypes/1.json
  def show
    @addresstype = Addresstype.find(params[:id])
    #test
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @addresstype }
    end
  end

  # GET /addresstypes/new
  # GET /addresstypes/new.json
  def new
    @addresstype = Addresstype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @addresstype }
    end
  end

  # GET /addresstypes/1/edit
  def edit
    @addresstype = Addresstype.find(params[:id])
  end

  # POST /addresstypes
  # POST /addresstypes.json
  def create
    @addresstype = Addresstype.new(params[:addresstype])

    respond_to do |format|
      if @addresstype.save
        format.html { redirect_to @addresstype, notice: 'Addresstype was successfully created.' }
        format.json { render json: @addresstype, status: :created, location: @addresstype }
      else
        format.html { render action: "new" }
        format.json { render json: @addresstype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /addresstypes/1
  # PUT /addresstypes/1.json
  def update
    @addresstype = Addresstype.find(params[:id])

    respond_to do |format|
      if @addresstype.update_attributes(params[:addresstype])
        format.html { redirect_to @addresstype, notice: 'Addresstype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @addresstype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresstypes/1
  # DELETE /addresstypes/1.json
  def destroy
    @addresstype = Addresstype.find(params[:id])
    @addresstype.destroy

    respond_to do |format|
      format.html { redirect_to addresstypes_url }
      format.json { head :no_content }
    end
  end
end
