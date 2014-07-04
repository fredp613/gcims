class ApplicationcustomtemplatesController < ApplicationController
  before_action :set_applicationcustomtemplate, only: [:show, :edit, :update, :destroy]

  # GET /applicationcustomtemplates
  # GET /applicationcustomtemplates.json
  def index
    @applicationcustomtemplates = Applicationcustomtemplate.all
  end

  # GET /applicationcustomtemplates/1
  # GET /applicationcustomtemplates/1.json
  def show
  end

  # GET /applicationcustomtemplates/new
  def new
    @applicationcustomtemplate = Applicationcustomtemplate.new
  end

  # GET /applicationcustomtemplates/1/edit
  def edit
  end

  # POST /applicationcustomtemplates
  # POST /applicationcustomtemplates.json
  def create
    @applicationcustomtemplate = Applicationcustomtemplate.new(applicationcustomtemplate_params)

    respond_to do |format|
      if @applicationcustomtemplate.save
        format.html { redirect_to @applicationcustomtemplate, notice: 'Applicationcustomtemplate was successfully created.' }
        format.json { render :show, status: :created, location: @applicationcustomtemplate }
      else
        format.html { render :new }
        format.json { render json: @applicationcustomtemplate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applicationcustomtemplates/1
  # PATCH/PUT /applicationcustomtemplates/1.json
  def update
    respond_to do |format|
      if @applicationcustomtemplate.update(applicationcustomtemplate_params)
        format.html { redirect_to @applicationcustomtemplate, notice: 'Applicationcustomtemplate was successfully updated.' }
        format.json { render :show, status: :ok, location: @applicationcustomtemplate }
      else
        format.html { render :edit }
        format.json { render json: @applicationcustomtemplate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicationcustomtemplates/1
  # DELETE /applicationcustomtemplates/1.json
  def destroy
    @applicationcustomtemplate.destroy
    respond_to do |format|
      format.html { redirect_to applicationcustomtemplates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_applicationcustomtemplate
      @applicationcustomtemplate = Applicationcustomtemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def applicationcustomtemplate_params
      params.require(:applicationcustomtemplate).permit(
        :id, 
        :user_id, 
        :application_id, 
        :customtemplate_id,
        :customfieldvalues_attributes => [:id, :value, :user_id, :applicationcustomtemplate_id]
        )
    end
end
