class ModelstatesController < ApplicationController
  before_action :set_modelstate, only: [:show, :edit, :update, :destroy]

  # GET /modelstates
  # GET /modelstates.json
  def index
    @modelstates = Modelstate.all
  end

  # GET /modelstates/1
  # GET /modelstates/1.json
  def show
  end

  # GET /modelstates/new
  def new
    @modelstate = Modelstate.new
  end

  # GET /modelstates/1/edit
  def edit
  end

  # POST /modelstates
  # POST /modelstates.json
  def create
    @modelstate = Modelstate.new(modelstate_params)

    respond_to do |format|
      if @modelstate.save
        format.html { redirect_to @modelstate, notice: 'Modelstate was successfully created.' }
        format.json { render :show, status: :created, location: @modelstate }
      else
        format.html { render :new }
        format.json { render json: @modelstate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /modelstates/1
  # PATCH/PUT /modelstates/1.json
  def update
    respond_to do |format|
      if @modelstate.update(params[:modelstates])
        format.html { redirect_to @modelstate, notice: 'Modelstate was successfully updated.' }
        format.json { render :show, status: :ok, location: @modelstate }
      else
        format.html { render :edit }
        format.json { render json: @modelstate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /modelstates/1
  # DELETE /modelstates/1.json
  def destroy
    @modelstate.destroy
    respond_to do |format|
      format.html { redirect_to modelstates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modelstate
      @modelstate = Modelstate.find(params[:id])
    end

    # # Never trust parameters from the scary internet, only allow the white list through.
    def modelstate_params
      params.require(:modelstate).permit(:user_id, :state, :object, :position)
    end
end
