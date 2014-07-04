class CustomfieldsController < ApplicationController
  before_action :set_customfield, only: [:show, :edit, :update, :destroy]

  # GET /customfields
  # GET /customfields.json
  def index
    @customfields = Customfield.all
  end

  # GET /customfields/1
  # GET /customfields/1.json
  def show
  end

  # GET /customfields/new
  def new
    @customfield = Customfield.new
  end

  # GET /customfields/1/edit
  def edit
  end

  # POST /customfields
  # POST /customfields.json
  def create
    @customfield = Customfield.new(customfield_params)

    respond_to do |format|
      if @customfield.save
        format.html { redirect_to @customfield, notice: 'Customfield was successfully created.' }
        format.json { render :show, status: :created, location: @customfield }
      else
        format.html { render :new }
        format.json { render json: @customfield.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customfields/1
  # PATCH/PUT /customfields/1.json
  def update
    respond_to do |format|
      if @customfield.update(customfield_params)
        format.html { redirect_to @customfield, notice: 'Customfield was successfully updated.' }
        format.json { render :show, status: :ok, location: @customfield }
      else
        format.html { render :edit }
        format.json { render json: @customfield.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customfields/1
  # DELETE /customfields/1.json
  def destroy
    @customfield.destroy
    respond_to do |format|
      format.html { redirect_to customfields_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customfield
      @customfield = Customfield.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customfield_params
      params.require(:customfield).permit(:field_type, :field_name, :field_class, :field_label, :required, :cfct_id,
        :customfieldvalues_attributes)
    end
end
