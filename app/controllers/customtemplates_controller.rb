class CustomtemplatesController < ApplicationController
  before_action :set_customtemplate, only: [:show, :edit, :update, :destroy]

  # GET /customtemplates
  # GET /customtemplates.json
  def index
    @customtemplates = Customtemplate.all
  end

  # GET /customtemplates/1
  # GET /customtemplates/1.json
  def show
  end

  # GET /customtemplates/new
  def new
    @customtemplate = Customtemplate.new
    # @customtemplate.wizard_id = params[:wizard_id]
    # @wizard = Wizard.where(id: @customtemplate.wizard_id)  

    # @eligibility = Cict.eligibilitytempate(@wizard.first.commitmentitem_id)  
  end

  # GET /customtemplates/1/edit
  def edit
  end

  # POST /customtemplates
  # POST /customtemplates.json
  def create
    @customtemplate = Customtemplate.new(customtemplate_params)
    
    respond_to do |format|
      if @customtemplate.save
        format.html { redirect_to @customtemplate, notice: 'Customtemplate was successfully created.' }
        format.json { render :show, status: :created, location: @customtemplate }
      else
        format.html { render :new }
        format.json { render json: @customtemplate.errors, status: :unprocessable_entity }
      end
    end
  end

  # def verify_eligibility
  #   # redirect_to root_url

  #   @customtemplate = Customtemplate.new(customtemplate_params)
  #   # @customtemplate.wizard_id = @customtemplate.wizard_id
  #   @wizard = Wizard.where(id: @customtemplate.wizard_id).first
  #   @wizard.modelstate_id = @wizard.next_state.id
  #   @wizard.save!
  #   respond_to do |format|
  #     if @customtemplate.valid?
  #       format.html { redirect_to edit_wizard_path(@customtemplate.wizard_id), notice: 'Customtemplate was successfully created.' }
  #       format.json { render :show, status: :created, location: @customtemplate }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @customtemplate.errors, status: :unprocessable_entity }
  #     end
  #   end

  # end

  # PATCH/PUT /customtemplates/1
  # PATCH/PUT /customtemplates/1.json
  def update
    respond_to do |format|
      if @customtemplate.update(customtemplate_params)
        format.html { redirect_to @customtemplate, notice: 'Customtemplate was successfully updated.' }
        format.json { render :show, status: :ok, location: @customtemplate }
      else
        format.html { render :edit }
        format.json { render json: @customtemplate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customtemplates/1
  # DELETE /customtemplates/1.json
  def destroy
    @customtemplate.destroy
    respond_to do |format|
      format.html { redirect_to customtemplates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customtemplate
      @customtemplate = Customtemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customtemplate_params
      params.require(:customtemplate).permit(:name, :active, :commitmentitem_id, :customtemplatetype_id, :wizard_id)
    end
end
