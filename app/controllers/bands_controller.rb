class BandsController < ApplicationController
  # GET /bands
  # GET /bands.json
  def index
    @bands = Band.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bands }
    end
  end

  # GET /bands/1
  # GET /bands/1.json
  def show
    @band = Band.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @band }
    end
  end

  # GET /bands/new
  # GET /bands/new.json
  def new
    @band = Band.new
     @client = params[:client_id]
    @from = params[:from]
    if @from
      session[:from] = @from
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @band }
    end
  end

  # GET /bands/1/edit
  def edit
    @band = Band.find(params[:id])
    @from = params[:from]
    if @from
      session[:from] = @from
    end

  end

  # POST /bands
  # POST /bands.json
  def create
    @band = Band.new(params[:band])

    respond_to do |format|
      if @band.save
        @client = @band.client
        @nav = AdditionalInformationNav.new(@client)
        @step = @nav.nav

          if !params[:back_button]
            case @step
            when 'corporation'
             format.html { redirect_to new_corporation_path(:client_id=>@client, :from=>'band') }
            when 'charity'
             format.html { redirect_to new_charity_path(:client_id=>@client, :from=>'band') }
            else
             flash[:notice] = 'Band information saved'
             format.html { redirect_to @client }
            end
            format.json { render json: @band, status: :created, location: @band }
          else
            if session[:from] == 'corporation'
              @corporation = @band.client.corporation
              format.html { redirect_to edit_corporation_path(@corporation.id)}
            end
            if session[:from] == 'client'
              format.html { redirect_to @client }
            end
          end
        
      else
        format.html { render action: "new" }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bands/1
  # PUT /bands/1.json
  def update
    @band = Band.find(params[:id])
    @client = @band.client

    respond_to do |format|
      if @band.update_attributes(params[:band])
        flash.now[:notice] = 'Band information saved'
        format.html { redirect_to client_path(@client) }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @band.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /bands/1
  # DELETE /bands/1.json
  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    @client = Client.find(@band.client)
    @client.update_attributes(:registeredband=>false)

    respond_to do |format|
      flash.now[:notice] = 'Band information successfully deleted'
      format.html { redirect_to request.referer }
      format.json { head :no_content }
      @client.build_band
      format.js
    end
  end
end
