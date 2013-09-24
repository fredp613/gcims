class FiscalyearsController < ApplicationController
  # GET /fiscalyears
  # GET /fiscalyears.json
  def index
    @fiscalyears = Fiscalyear.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fiscalyears }
    end
  end

  # GET /fiscalyears/1
  # GET /fiscalyears/1.json
  def show
    @fiscalyear = Fiscalyear.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fiscalyear }
    end
  end

  # GET /fiscalyears/new
  # GET /fiscalyears/new.json
  def new
    @fiscalyear = Fiscalyear.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fiscalyear }
    end
  end

  # GET /fiscalyears/1/edit
  def edit
    @fiscalyear = Fiscalyear.find(params[:id])
  end

  # POST /fiscalyears
  # POST /fiscalyears.json
  def create
    @fiscalyear = Fiscalyear.new(params[:fiscalyear])

    respond_to do |format|
      if @fiscalyear.save
        format.html { redirect_to @fiscalyear, notice: 'Fiscalyear was successfully created.' }
        format.json { render json: @fiscalyear, status: :created, location: @fiscalyear }
      else
        format.html { render action: "new" }
        format.json { render json: @fiscalyear.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fiscalyears/1
  # PUT /fiscalyears/1.json
  def update
    @fiscalyear = Fiscalyear.find(params[:id])

    respond_to do |format|
      if @fiscalyear.update_attributes(params[:fiscalyear])
        format.html { redirect_to @fiscalyear, notice: 'Fiscalyear was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fiscalyear.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fiscalyears/1
  # DELETE /fiscalyears/1.json
  def destroy
    @fiscalyear = Fiscalyear.find(params[:id])
    @fiscalyear.destroy

    respond_to do |format|
      format.html { redirect_to fiscalyears_url }
      format.json { head :no_content }
    end
  end
end
