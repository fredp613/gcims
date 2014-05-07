class UsersController < ApplicationController
	def index
		@users = User.where.not(id: current_user.id)

		respond_to do |format|
			format.html 
			format.json { render json: @users }
			format.js			
		end		
	end

	def show
		@user = User.find(params[:id])

		respond_to do |format|
			format.html 
			format.json { render json: @users }
			format.js			
		end		
	end

	def edit
		@user = User.find(params[:id])		
	end

	def update
		@user = User.find(params[:id])

		respond_to do |format|
	      if @user.update_attributes(params[:user])
	        format.html { redirect_to @user, notice: 'User was successfully updated.' }
	        format.json { head :no_content }
	        format.js
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @user.errors, status: :unprocessable_entity }
	        format.js
	      end
   		 end
	end

	def new 
		@user = User.new
	end

	def create
	  @user = User.new(params[:user])

	  respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js
      end
    end
	end
end