class ApplicationcustomtemplatesController < ApplicationController
  before_action :set_applicationcustomtemplate, only: [:show, :update,  :destroy]
  before_action :set_applicationcustomtemplate_special, only: [:edit]

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

    @application = Application.find(params[:app_id])
    @customtemplate = Customtemplate.find(params[:ct_id])
   
   
    # @ps = Applicationcustomtemplate.new
    if @customtemplate.for_application(@application, @customtemplate).blank?
      @ps = Customtemplate.find(params[:ct_id])
    else      
      @ps = @customtemplate.for_application(@application, @customtemplate).customfieldvalues
    end
  end

  # GET /applicationcustomtemplates/1/edit
  def edit
    @application = Application.find(params[:app_id])
    @customtemplate = Customtemplate.find(params[:ct_id])
    # @ps = @customtemplate.for_application(@application, @customtemplate).customfieldvalues

  end

  # POST /applicationcustomtemplates
  # POST /applicationcustomtemplates.json
  def create
    @applicationcustomtemplate = Applicationcustomtemplate.new(applicationcustomtemplate_params)

    respond_to do |format|
      if @applicationcustomtemplate.save
        format.html { redirect_to project_path(:id=>@applicationcustomtemplate.application.project_id), notice: 'Application custom template was successfully created.' }
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
        format.html { redirect_to project_path(:id=>@applicationcustomtemplate.application.project_id), notice: 'Application custom template was successfully updated.' }
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

  # def program_specific
  #   @application = Application.find(params[:app_id])
  #   @customtemplate = Customtemplate.find(params[:ct_id])
  #   @act = Applicationcustomtemplate.where(application_id: @application.id, customtemplate_id: @customtemplate.id).first
  #   if @act 
  #     @applicationcustomtemplate = Applicationcustomtemplate.find(@act.map(&:id))
  #   else
  #     @applicationcustomtemplate = Applicationcustomtemplate.new
  #   end
  #   # @ps = Applicationcustomtemplate.new
  #   if @customtemplate.for_application(@application, @customtemplate).blank?
  #     @ps = Customtemplate.find(params[:ct_id])
  #   else      
  #     @ps = @customtemplate.for_application(@application, @customtemplate).customfieldvalues
  #   end
  # end


  # def submit_program_specific
  #     @applicationcustomtemplate = Applicationcustomtemplate.find(applicationcustomtemplate_params)


  #   # if params[:save]
  #     respond_to do |format|
  #       # if @application.valid? 
  #         @applicationcustomtemplate.update_attributes(params[:applicationcustomtemplate])
  #         format.html { redirect_to project_path(:id=>@applicationcustomtemplate.application.project), notice: "Application updated!" }
  #         format.json { render :show, status: :ok, location: @applicationcustomtemplate }       
  #       # else
  #       #   format.html { render :program_specific }
  #       #   format.json { render json: @applicationcustomtemplate.errors, status: :unprocessable_entity }
  #       # end
  #      end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_applicationcustomtemplate
      @applicationcustomtemplate = Applicationcustomtemplate.find(params[:id])
    end

    def set_applicationcustomtemplate_special
      @applicationcustomtemplate = Applicationcustomtemplate.find_by_app_ct(params[:app_id], params[:ct_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def applicationcustomtemplate_params
      params.require(:applicationcustomtemplate).permit(
        :id, 
        :user_id, 
        :application_id, 
        :customtemplate_id,
        :customfieldvalues_attributes => [:id, :value, :user_id, :applicationcustomtemplate_id, :customfield_id]
        )

    end
end
