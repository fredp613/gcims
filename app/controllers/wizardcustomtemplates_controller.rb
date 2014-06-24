class WizardcustomtemplatesController < ApplicationController
  before_action :set_wizardcustomtemplate, only: [:show, :edit, :update, :destroy]

  # GET /wizardcustomtemplates
  # GET /wizardcustomtemplates.json
  def index
    @wizardcustomtemplates = Wizardcustomtemplate.all
  end

  # GET /wizardcustomtemplates/1
  # GET /wizardcustomtemplates/1.json
  def show
  end

  # GET /wizardcustomtemplates/new
  def new
    @wizardcustomtemplate = Wizardcustomtemplate.new
  end

  # GET /wizardcustomtemplates/1/edit
  def edit
  end

  # POST /wizardcustomtemplates
  # POST /wizardcustomtemplates.json
  def create
    @wizardcustomtemplate = Wizardcustomtemplate.new(wizardcustomtemplate_params)

    respond_to do |format|
      if @wizardcustomtemplate.save
        format.html { redirect_to @wizardcustomtemplate, notice: 'Wizardcustomtemplate was successfully created.' }
        format.json { render :show, status: :created, location: @wizardcustomtemplate }
      else
        format.html { render :new }
        format.json { render json: @wizardcustomtemplate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wizardcustomtemplates/1
  # PATCH/PUT /wizardcustomtemplates/1.json
  def update
    respond_to do |format|
      if @wizardcustomtemplate.update(wizardcustomtemplate_params)
        format.html { redirect_to @wizardcustomtemplate, notice: 'Wizardcustomtemplate was successfully updated.' }
        format.json { render :show, status: :ok, location: @wizardcustomtemplate }
      else
        format.html { render :edit }
        format.json { render json: @wizardcustomtemplate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wizardcustomtemplates/1
  # DELETE /wizardcustomtemplates/1.json
  def destroy
    @wizardcustomtemplate.destroy
    respond_to do |format|
      format.html { redirect_to wizardcustomtemplates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wizardcustomtemplate
      @wizardcustomtemplate = Wizardcustomtemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wizardcustomtemplate_params
      params.require(:wizardcustomtemplate).permit(
        :id,
        :user_id, 
        :customtemplate_id,
        :wizard_id,
        :customfieldvalues_attributes => [:id, :value, :user_id, :wizardcustomtemplate_id]
        )
    end
end
