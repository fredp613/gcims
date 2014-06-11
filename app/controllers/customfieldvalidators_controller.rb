class CustomfieldvalidatorsController < ApplicationController
  before_action :set_customfieldvalidator, only: [:show, :edit, :update, :destroy]

  # GET /customfieldvalidators
  # GET /customfieldvalidators.json
  def index
    @customfieldvalidators = Customfieldvalidator.all
  end

  # GET /customfieldvalidators/1
  # GET /customfieldvalidators/1.json
  def show
  end

  # GET /customfieldvalidators/new
  def new
    @customfieldvalidator = Customfieldvalidator.new
  end

  # GET /customfieldvalidators/1/edit
  def edit
  end

  # POST /customfieldvalidators
  # POST /customfieldvalidators.json
  def create
    @customfieldvalidator = Customfieldvalidator.new(customfieldvalidator_params)

    respond_to do |format|
      if @customfieldvalidator.save
        format.html { redirect_to @customfieldvalidator, notice: 'Customfieldvalidator was successfully created.' }
        format.json { render :show, status: :created, location: @customfieldvalidator }
      else
        format.html { render :new }
        format.json { render json: @customfieldvalidator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customfieldvalidators/1
  # PATCH/PUT /customfieldvalidators/1.json
  def update
    respond_to do |format|
      if @customfieldvalidator.update(customfieldvalidator_params)
        format.html { redirect_to @customfieldvalidator, notice: 'Customfieldvalidator was successfully updated.' }
        format.json { render :show, status: :ok, location: @customfieldvalidator }
      else
        format.html { render :edit }
        format.json { render json: @customfieldvalidator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customfieldvalidators/1
  # DELETE /customfieldvalidators/1.json
  def destroy
    @customfieldvalidator.destroy
    respond_to do |format|
      format.html { redirect_to customfieldvalidators_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customfieldvalidator
      @customfieldvalidator = Customfieldvalidator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customfieldvalidator_params
      params.require(:customfieldvalidator).permit(:customfield_id, :type)
    end
end
