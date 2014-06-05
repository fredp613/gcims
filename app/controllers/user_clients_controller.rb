class UserClientsController < ApplicationController
  before_action :set_user_client, only: [:show, :edit, :update, :destroy]

  # GET /user_clients
  # GET /user_clients.json
  def index
    @user_clients = UserClient.all
  end

  # GET /user_clients/1
  # GET /user_clients/1.json
  def show
  end

  # GET /user_clients/new
  def new
    @user_client = UserClient.new
  end

  # GET /user_clients/1/edit
  def edit
  end

  # POST /user_clients
  # POST /user_clients.json
  def create
    @user_client = UserClient.new(user_client_params)

    respond_to do |format|
      if @user_client.save
        format.html { redirect_to @user_client, notice: 'User client was successfully created.' }
        format.json { render :show, status: :created, location: @user_client }
      else
        format.html { render :new }
        format.json { render json: @user_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_clients/1
  # PATCH/PUT /user_clients/1.json
  def update
    respond_to do |format|
      if @user_client.update(user_client_params)
        format.html { redirect_to @user_client, notice: 'User client was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_client }
      else
        format.html { render :edit }
        format.json { render json: @user_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_clients/1
  # DELETE /user_clients/1.json
  def destroy
    @user_client.destroy
    respond_to do |format|
      format.html { redirect_to user_clients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_client
      @user_client = UserClient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_client_params
      params.require(:user_client).permit(:user_id, :client_id)
    end
end
