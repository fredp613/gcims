class CfctsController < ApplicationController
  before_action :set_cfct, only: [:show, :edit, :update, :destroy]

  # GET /cfcts
  # GET /cfcts.json
  def index
    @cfcts = Cfct.all
  end

  # GET /cfcts/1
  # GET /cfcts/1.json
  def show
  end

  # GET /cfcts/new
  def new
    @cfct = Cfct.new
  end

  # GET /cfcts/1/edit
  def edit
  end

  # POST /cfcts
  # POST /cfcts.json
  def create
    @cfct = Cfct.new(cfct_params)

    respond_to do |format|
      if @cfct.save
        format.html { redirect_to @cfct, notice: 'Cfct was successfully created.' }
        format.json { render :show, status: :created, location: @cfct }
      else
        format.html { render :new }
        format.json { render json: @cfct.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cfcts/1
  # PATCH/PUT /cfcts/1.json
  def update
    respond_to do |format|
      if @cfct.update(cfct_params)
        format.html { redirect_to @cfct, notice: 'Cfct was successfully updated.' }
        format.json { render :show, status: :ok, location: @cfct }
      else
        format.html { render :edit }
        format.json { render json: @cfct.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cfcts/1
  # DELETE /cfcts/1.json
  def destroy
    @cfct.destroy
    respond_to do |format|
      format.html { redirect_to cfcts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cfct
      @cfct = Cfct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cfct_params
      params.require(:cfct).permit(:customfield_id, :customtemplate_id)
    end
end
