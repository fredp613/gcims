class WizardsController < ApplicationController
  before_action :set_wizard, only: [:show, :edit,:update, :destroy, :eligibility]


  # GET /wizards
  # GET /wizards.json
  def index
    @wizards = Wizard.all
  end

  # GET /wizards/1
  # GET /wizards/1.json
  def show
  end

  # GET /wizards/new
  def new
    @wizard = Wizard.new
    # @wizard.modelstate_id = @wizard.initial_state
  end

  def eligibility
    # @wizard = Wizard.find(params[:id])  

      #@wizardcustomtemplate = Wizardcustomtemplate.find_by_wizard(params[:id])
      # @wizardcustomtemplate.wizard_state_id = @wizard.current_state.first.id
     
      #dont forget to scope this to the actual wizardtemplate
      if @wizard.customfieldvalues.blank?
        @eligibility = Cict.eligibilitytempate(@wizard.commitmentitem_id)
      else
        @eligibility = @wizard.wizardcustomtemplates.first.customfieldvalues
      end
      
      # if @wizard.customfieldvalues.blank?        
      #     @wizard.wizardcustomtemplates.build.customfieldvalues.build        
      # end
  end

  # GET /wizards/1/edit
  def edit

  end

  # POST /wizards
  # POST /wizards.json
  def create
    @wizard = Wizard.new(wizard_params)
    @wizard.modelstate_id = @wizard.next_state.id


    respond_to do |format|
      if @wizard.save

        # @wizardcustomtemplate = Wizardcustomtemplate.new
        # @wizardcustomtemplate.wizard_id = @wizard.id
         @eligibility = Cict.eligibilitytempate(@wizard.commitmentitem_id)
        # @wizardcustomtemplate.customtemplate_id = @eligibility.first.id
        # @wizardcustomtemplate.user_id = current_user.id
        # @wizardcustomtemplate.save!

        if @eligibility.blank?
          format.html { redirect_to edit_wizard_path(@wizard), notice: "Current step: #{@wizard.current_state.first.state}" }
        else


          format.html { redirect_to eligibility_wizards_path(:id=>@wizard.id), notice: "Current step: #{@wizard.current_state.first.state}" }
        end        
        format.json { render :show, status: :created, location: @wizard }
      else
        format.html { render :new }
        format.json { render json: @wizard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wizards/1
  # PATCH/PUT /wizards/1.json
  def update
    #eligibility is a post so the submit probably wont work you will need to create a custom action in
    #this controller somewhere which should update the existing wizard as well (maybe to a get instead)
    respond_to do |format|
      if @wizard.update(wizard_params)

        if params[:next]
          unless @wizard.last_state? 
            @wizard.modelstate_id = @wizard.next_state.id
          end
        end

        if params[:previous]
            @wizard.modelstate_id = @wizard.previous_state.id
        end 

        @wizard.save!

        @eligibility = Cict.eligibilitytempate(@wizard.commitmentitem_id)

        if @wizard.last_state?
          format.html { redirect_to root_url, notice: 'Please complete the application.' }
        else
          if !@eligibility.blank? || @wizard.current_state.first.state == "Eligibility"
            format.html { redirect_to eligibility_wizards_path(:id=>@wizard.id), notice: "Current step: #{@wizard.current_state.first.state}" }
          else
            format.html { redirect_to edit_wizard_path(@wizard), notice: "Current step: #{@wizard.current_state.first.state}" }
          end
        end
          format.json { render :show, status: :ok, location: @wizard }       
      else
        format.html { render :edit }
        format.json { render json: @wizard.errors, status: :unprocessable_entity }
    end
    end
  end

  def verify_eligibility
     @wizard = Wizard.find(params[:wizard][:id])

    if params[:verify]
      respond_to do |format|
        if @wizard.valid? 
         
          format.html { redirect_to eligibility_wizards_path(wizard_id: @wizardcustomtemplate.wizard_id), notice: "Current step: #{@wizard.current_state.first.state}" }
          format.json { render :show, status: :ok, location: @customtemplate }       
        else
          format.html { render :eligibility }
          format.json { render json: @wizardcustomtemplate.errors, status: :unprocessable_entity }
        end
      end
    end

    if params[:next]
      respond_to do |format|
       if @wizard.valid? 
          @wizard.modelstate_id = @wizard.next_state.id
          @wizard.update(wizard_params)      


          format.html { redirect_to edit_wizard_path(@wizard), notice: "Current step:  #{@wizard.current_state.first.state}" }
          format.json { render :show, status: :ok, location: @wizardcustomtemplate }       
        else
          format.html { render :eligibility }
          format.json { render json: @wizardcustomtemplate.errors, status: :unprocessable_entity }
        end
      end
    end

    if params[:previous]
      respond_to do |format|
        @wizard.modelstate_id = @wizard.previous_state.id

        
        format.html { redirect_to edit_wizard_path(@wizard.id), notice: "Current step:  #{@wizard.current_state.first.state}" }
      end
    end 

  end

  # DELETE /wizards/1
  # DELETE /wizards/1.json
  def destroy
    @wizard.destroy
    respond_to do |format|
      format.html { redirect_to wizards_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wizard
      @wizard = Wizard.find(params[:id])
    end





    # Never trust parameters from the scary internet, only allow the white list through.
     def wizard_params
      params.require(:wizard).permit(:id, :user_id, :modelstate_id, :commitmentitem_id, 
        :wizardcustomtemplates_attributes => [:id, :wizard_id, :customtemplate_id, 
         :customfieldvalues_attributes=>[:id, :user_id, :value, :wizardcustomtemplate_id, :customfield_id]])
    end
end
