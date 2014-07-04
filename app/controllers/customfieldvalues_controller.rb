class CustomfieldvaluesController < ApplicationController
  before_action :set_customfieldvalue, only: [:show, :edit, :update, :destroy]

  # GET /customfieldvalues
  # GET /customfieldvalues.json
  def index
    @customfieldvalues = Customfieldvalue.all
  end

  # GET /customfieldvalues/1
  # GET /customfieldvalues/1.json
  def show
  end

  # GET /customfieldvalues/new
  def new
    @customfieldvalue = Customfieldvalue.new
  end

  # GET /customfieldvalues/1/edit
  def edit
  end

  # POST /customfieldvalues
  # POST /customfieldvalues.json
  def create
    @customfieldvalue = Customfieldvalue.new(customfieldvalue_params)

    respond_to do |format|
      if @customfieldvalue.save
        format.html { redirect_to @customfieldvalue, notice: 'Customfieldvalue was successfully created.' }
        format.json { render :show, status: :created, location: @customfieldvalue }
      else
        format.html { render :new }
        format.json { render json: @customfieldvalue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customfieldvalues/1
  # PATCH/PUT /customfieldvalues/1.json
  def update
    respond_to do |format|
      if @customfieldvalue.update(customfieldvalue_params)
        format.html { redirect_to @customfieldvalue, notice: 'Customfieldvalue was successfully updated.' }
        format.json { render :show, status: :ok, location: @customfieldvalue }
      else
        format.html { render :edit }
        format.json { render json: @customfieldvalue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customfieldvalues/1
  # DELETE /customfieldvalues/1.json
  def destroy
    @customfieldvalue.destroy
    respond_to do |format|
      format.html { redirect_to customfieldvalues_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customfieldvalue
      @customfieldvalue = Customfieldvalue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customfieldvalue_params
      params.require(:customfieldvalue).permit(:id, :value, :user_id, :wizardcustomtemplate_id, :customfield_id, :applicationcustomtemplate_id)
    end
end
