class CustomtemplatetypesController < ApplicationController
  before_action :set_customtemplatetype, only: [:show, :edit, :update, :destroy]

  # GET /customtemplatetypes
  # GET /customtemplatetypes.json
  def index
    @customtemplatetypes = Customtemplatetype.all
  end

  # GET /customtemplatetypes/1
  # GET /customtemplatetypes/1.json
  def show
  end

  # GET /customtemplatetypes/new
  def new
    @customtemplatetype = Customtemplatetype.new
  end

  # GET /customtemplatetypes/1/edit
  def edit
  end

  # POST /customtemplatetypes
  # POST /customtemplatetypes.json
  def create
    @customtemplatetype = Customtemplatetype.new(customtemplatetype_params)

    respond_to do |format|
      if @customtemplatetype.save
        format.html { redirect_to @customtemplatetype, notice: 'Customtemplatetype was successfully created.' }
        format.json { render :show, status: :created, location: @customtemplatetype }
      else
        format.html { render :new }
        format.json { render json: @customtemplatetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customtemplatetypes/1
  # PATCH/PUT /customtemplatetypes/1.json
  def update
    respond_to do |format|
      if @customtemplatetype.update(customtemplatetype_params)
        format.html { redirect_to @customtemplatetype, notice: 'Customtemplatetype was successfully updated.' }
        format.json { render :show, status: :ok, location: @customtemplatetype }
      else
        format.html { render :edit }
        format.json { render json: @customtemplatetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customtemplatetypes/1
  # DELETE /customtemplatetypes/1.json
  def destroy
    @customtemplatetype.destroy
    respond_to do |format|
      format.html { redirect_to customtemplatetypes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customtemplatetype
      @customtemplatetype = Customtemplatetype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customtemplatetype_params
      params.require(:customtemplatetype).permit(:ct_type, :modelstate_id)
    end
end
