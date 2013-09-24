class ApplicationtypesController < ApplicationController
  # GET /applicationtypes
  # GET /applicationtypes.json
  def index
    @applicationtypes = Applicationtype.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applicationtypes }
    end
  end

  # GET /applicationtypes/1
  # GET /applicationtypes/1.json
  def show
    @applicationtype = Applicationtype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @applicationtype }
    end
  end

  # GET /applicationtypes/new
  # GET /applicationtypes/new.json
  def new
    @applicationtype = Applicationtype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @applicationtype }
    end
  end

  # GET /applicationtypes/1/edit
  def edit
    @applicationtype = Applicationtype.find(params[:id])
  end

  # POST /applicationtypes
  # POST /applicationtypes.json
  def create
    @applicationtype = Applicationtype.new(params[:applicationtype])

    respond_to do |format|
      if @applicationtype.save
        format.html { redirect_to @applicationtype, notice: 'Applicationtype was successfully created.' }
        format.json { render json: @applicationtype, status: :created, location: @applicationtype }
      else
        format.html { render action: "new" }
        format.json { render json: @applicationtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /applicationtypes/1
  # PUT /applicationtypes/1.json
  def update
    @applicationtype = Applicationtype.find(params[:id])

    respond_to do |format|
      if @applicationtype.update_attributes(params[:applicationtype])
        format.html { redirect_to @applicationtype, notice: 'Applicationtype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @applicationtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicationtypes/1
  # DELETE /applicationtypes/1.json
  def destroy
    @applicationtype = Applicationtype.find(params[:id])
    @applicationtype.destroy

    respond_to do |format|
      format.html { redirect_to applicationtypes_url }
      format.json { head :no_content }
    end
  end
end
