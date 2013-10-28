class CorporationsController < ApplicationController
  # GET /corporations
  # GET /corporations.json
  def index
    @corporations = Corporation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @corporations }
    end
  end

  # GET /corporations/1
  # GET /corporations/1.json
  def show
    @corporation = Corporation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @corporation }
    end
  end

  # GET /corporations/new
  # GET /corporations/new.json
  def new
    @corporation = Corporation.new
    @client = params[:client_id]

    if @from
      session[:from] = @from
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @corporation }
    end
  end

  # GET /corporations/1/edit
  def edit
    @corporation = Corporation.find(params[:id])

    if @from
      session[:from] = @from
    end
  end

  # POST /corporations
  # POST /corporations.json
  def create
    @corporation = Corporation.new(params[:corporation])

    respond_to do |format|
      if @corporation.save
        @client = @corporation.client
        @nav = AdditionalInformationNav.new(@client)
        @step = @nav.nav

          if !params[:back_button]
            case @step
            when 'band'
             format.html { redirect_to new_band_path(:client_id=>@client, :from=>'corporation') }
            when 'charity'
             format.html { redirect_to new_charity_path(:client_id=>@client, :from=>'corporation') }
            else
             format.html { redirect_to @client, notice: 'Saved' }
            end
            format.json { render json: @corporation, status: :created, location: @corporation }
          else
            format.html { redirect_to @client }
          end

      else
        format.html { render action: "new" }
        format.json { render json: @corporation.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /corporations/1
  # PUT /corporations/1.json
  def update
    @corporation = Corporation.find(params[:id])
    @client = @corporation.client
    respond_to do |format|
      if @corporation.update_attributes(params[:corporation])
        format.html { redirect_to client_path(@client), notice: 'Corporation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @corporation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /corporations/1
  # DELETE /corporations/1.json
  def destroy
    @corporation = Corporation.find(params[:id])
    @corporation.destroy
    @client = Client.find(@corporation.client)
    @client.update_attributes(:incorporated=>false)

    respond_to do |format|
      format.html { redirect_to request.referer }
      format.json { head :no_content }
      @client.build_corporation
      format.js
    end
  end
end
