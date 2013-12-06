class OtherfundersController < ApplicationController
  # GET /otherfunders
  # GET /otherfunders.json
  def index
    @otherfunders = Otherfunder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @otherfunders }
    end
  end

  # GET /otherfunders/1
  # GET /otherfunders/1.json
  def show
    @otherfunder = Otherfunder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @otherfunder }
    end
  end

  # GET /otherfunders/new
  # GET /otherfunders/new.json
  def new
    @otherfunder = Otherfunder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @otherfunder }
    end
  end

  # GET /otherfunders/1/edit
  def edit
    @otherfunder = Otherfunder.find(params[:id])
  end

  # POST /otherfunders
  # POST /otherfunders.json
  def create
    @otherfunder = Otherfunder.new(params[:otherfunder])

    respond_to do |format|
      if @otherfunder.save
        format.html { redirect_to @otherfunder, notice: 'Otherfunder was successfully created.' }
        format.json { render json: @otherfunder, status: :created, location: @otherfunder }
      else
        format.html { render action: "new" }
        format.json { render json: @otherfunder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /otherfunders/1
  # PUT /otherfunders/1.json
  def update
    @otherfunder = Otherfunder.find(params[:id])

    respond_to do |format|
      if @otherfunder.update_attributes(params[:otherfunder])
        format.html { redirect_to @otherfunder, notice: 'Otherfunder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @otherfunder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /otherfunders/1
  # DELETE /otherfunders/1.json
  def destroy
    @otherfunder = Otherfunder.find(params[:id])
    @otherfunder.destroy

    respond_to do |format|
      format.html { redirect_to otherfunders_url }
      format.json { head :no_content }
    end
  end
end
