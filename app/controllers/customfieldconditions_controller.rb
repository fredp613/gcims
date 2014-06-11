class CustomfieldconditionsController < ApplicationController
  before_action :set_customfieldcondition, only: [:show, :edit, :update, :destroy]

  # GET /customfieldconditions
  # GET /customfieldconditions.json
  def index
    @customfieldconditions = Customfieldcondition.all
  end

  # GET /customfieldconditions/1
  # GET /customfieldconditions/1.json
  def show
  end

  # GET /customfieldconditions/new
  def new
    @customfieldcondition = Customfieldcondition.new
  end

  # GET /customfieldconditions/1/edit
  def edit
  end

  # POST /customfieldconditions
  # POST /customfieldconditions.json
  def create
    @customfieldcondition = Customfieldcondition.new(customfieldcondition_params)

    respond_to do |format|
      if @customfieldcondition.save
        format.html { redirect_to @customfieldcondition, notice: 'Customfieldcondition was successfully created.' }
        format.json { render :show, status: :created, location: @customfieldcondition }
      else
        format.html { render :new }
        format.json { render json: @customfieldcondition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customfieldconditions/1
  # PATCH/PUT /customfieldconditions/1.json
  def update
    respond_to do |format|
      if @customfieldcondition.update(customfieldcondition_params)
        format.html { redirect_to @customfieldcondition, notice: 'Customfieldcondition was successfully updated.' }
        format.json { render :show, status: :ok, location: @customfieldcondition }
      else
        format.html { render :edit }
        format.json { render json: @customfieldcondition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customfieldconditions/1
  # DELETE /customfieldconditions/1.json
  def destroy
    @customfieldcondition.destroy
    respond_to do |format|
      format.html { redirect_to customfieldconditions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customfieldcondition
      @customfieldcondition = Customfieldcondition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customfieldcondition_params
      params.require(:customfieldcondition).permit(:customfieldvalidator_id, :condition)
    end
end
