class CictsController < ApplicationController
  before_action :set_cict, only: [:show, :edit, :update, :destroy]

  # GET /cicts
  # GET /cicts.json
  def index
    @cicts = Cict.all
  end

  # GET /cicts/1
  # GET /cicts/1.json
  def show
  end

  # GET /cicts/new
  def new
    @cict = Cict.new
  end

  # GET /cicts/1/edit
  def edit
  end

  # POST /cicts
  # POST /cicts.json
  def create
    @cict = Cict.new(cict_params)

    respond_to do |format|
      if @cict.save
        format.html { redirect_to @cict, notice: 'Cict was successfully created.' }
        format.json { render :show, status: :created, location: @cict }
      else
        format.html { render :new }
        format.json { render json: @cict.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cicts/1
  # PATCH/PUT /cicts/1.json
  def update
    respond_to do |format|
      if @cict.update(cict_params)
        format.html { redirect_to @cict, notice: 'Cict was successfully updated.' }
        format.json { render :show, status: :ok, location: @cict }
      else
        format.html { render :edit }
        format.json { render json: @cict.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cicts/1
  # DELETE /cicts/1.json
  def destroy
    @cict.destroy
    respond_to do |format|
      format.html { redirect_to cicts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cict
      @cict = Cict.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cict_params
      params.require(:cict).permit(:commitmentitem_id, :customtemplate_id)
    end
end
