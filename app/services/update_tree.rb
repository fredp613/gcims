class UpdateTree

	def initialize(user, productserviceline, subserviceline, summarycommitment, 
		commitmentitem, controller, action, params = {})
		@params = params
		@psl = productserviceline
		@user = user
		@action = action
		@ssl = subserviceline
		@sc = summarycommitment
		@ci = commitmentitem
		@controller = controller

	end

	def update_tree_instances

		if @controller == "ci"
		 update_up_ci
		 #update_up_sc
		 #update_up_ssl

		elsif @controller == "sc"
		 update_down_sc
		 update_up_sc
		 

		elsif @controller == "ssl"
		 update_down_ssl
		 update_up_ssl

		else
		 update_down_psl

		end

	end

	def update_down_psl
		psl = @psl.subservicelines.find(:all)
			psl.each do |ssl|
				#ssl.active = @psl.active
				ssl.fiscalyears_save(@psl.fiscalyears)
				ssl.user = @psl.user
				ssl.update_attributes(@params[:subserviceline])
				ssl.summarycommitments.each do |sc|
					#sc.active = @psl.active
					sc.fiscalyears_save(@psl.fiscalyears)
					sc.user = @psl.user
					sc.update_attributes(@params[:summarycommitment])
					sc.commitmentitems.each do |ci|
						#ci.active = @psl.active
						ci.fiscalyears_save(@psl.fiscalyears)
						ci.user = @psl.user
						ci.update_attributes(@params[:commitmentitem])
					end
				end
			end
	end

	def update_down_ssl	
		ssl = @ssl.summarycommitments.find(:all)
		  ssl.each do |sc| 
			#sc.active = @ssl.active
			sc.fiscalyears_save(@ssl.fiscalyears)
			sc.user = @ssl.user
			sc.update_attributes(@params[:summarycommitment])
			sc.commitmentitems.find(:all).each do |ci|
				#ci.active = @ssl.active
				ci.fiscalyear_save(@ssl.fiscalyears)
				ci.user = @ssl.user
				ci.update_attributes(@params[:commitmentitem])
			end
		end 
	end

	def update_down_sc
		sc = @sc.commitmentitems.find(:all)
		sc.each do |ci|
		 #ci.active = @sc.active
		 ci.fiscalyear_save(@sc.fiscalyears)
		 ci.user = @sc.user
		 ci.update_attributes(@params[:commitmentitem])
		end
	end

	def update_up_ci
		
		@cifys = Fyci.find(:all, :conditions => ['commitmentitem_id in (?)', @sc.commitmentitems.map(&:id)]).count
		#current branch has no active leafs OR current branch only has 1 leaf 
		if @cifys == 0 
			@sc.fiscalyears_save(@ci.fiscalyear_ids)
			@sc.user = @ci.user
			@sc.update_attributes(@params[:summarycommitment])
		else
			@fiscalyears = @ci.fiscalyear_ids.reject{ |e| @sc.fiscalyear_ids.include? e}
			@sc.fiscalyear_ids = @fiscalyears + @sc.fiscalyear_ids	
			@sc.user = @ci.user
			@sc.update_attributes(@params[:summarycommitment])
		end
		@scfys = Fysc.find(:all, :conditions => ['summarycommitment_id in (?)', @ssl.summarycommitments.map(&:id)]).count

		if @scfys == 0 
			@ssl.fiscalyears_save(@ci.fiscalyear_ids)
			@ssl.user = @ci.user
			@ssl.update_attributes(@params[:subserviceline])
		else
			@fy_ssl = @ci.fiscalyears.reject{ |e| @ssl.fiscalyears.include? e}
			@ssl.fiscalyears_save = @fy_ssl + @ssl.fiscalyear_ids
			@ssl.user = @ci.user
			@ssl.update_attributes(@params[:subserviceline])
		end
		@sslfys = Fyssl.find(:all, :conditions => ['subserviceline_id in (?)', @psl.subservicelines.map(&:id)]).count

		if @sslfys == 0
			@psl.fiscalyear_ids = @ci.fiscalyear_ids
			@psl.user = @ci.user
			@psl.update_attributes(@params[:productserviceline])
		else
			@fy_psl = @ci.fiscalyear_ids.reject{ |e| @psl.fiscalyear_ids.include? e}
			@psl.fiscalyear_ids = @fy_psl + @psl.fiscalyear_ids
			@psl.user = @ci.user
			@psl.update_attributes(@params[:productserviceline])
		end
	end


	def update_up_sc
		
		@scfys = Fysc.find(:all, :conditions => ['summarycommitment_id in (?)', @ssl.summarycommitments.map(&:id)]).count

		if @scfys == 0 
			@ssl.fiscalyear_ids = @sc.fiscalyear_ids
			@ssl.user = @sc.user
			@ssl.update_attributes(@params[:subserviceline])
		else
			@fy_ssl = @sc.fiscalyear_ids.reject{ |e| @ssl.fiscalyear_ids.include? e}
			@ssl.fiscalyear_ids = @fy_ssl + @ssl.fiscalyear_ids
			@ssl.user = @sc.user
			@ssl.update_attributes(@params[:subserviceline])
		end
		@sslfys = Fyssl.find(:all, :conditions => ['subserviceline_id in (?)', @psl.subservicelines.map(&:id)]).count

		if @sslfys == 0
			@psl.fiscalyear_ids = @sc.fiscalyear_ids
			@psl.user = @sc.user
			@psl.update_attributes(@params[:productserviceline])
		else
			@fy_psl = @sc.fiscalyear_ids.reject{ |e| @psl.fiscalyear_ids.include? e}
			@psl.fiscalyear_ids = @fy_psl + @psl.fiscalyear_ids
			@psl.user = @sc.user
			@psl.update_attributes(@params[:productserviceline])
		end

		
	
	end

	def update_up_ssl
		@sslfys = Fyssl.find(:all, :conditions => ['subserviceline_id in (?)', @psl.subservicelines.map(&:id)]).count

		if @sslfys == 0
			@psl.fiscalyear_ids = @ssl.fiscalyear_ids
			@psl.user = @ssl.user
			@psl.update_attributes(@params[:productserviceline])
		else
			@fy_psl = @ssl.fiscalyear_ids.reject{ |e| @psl.fiscalyear_ids.include? e}
			@psl.fiscalyear_ids = @fy_psl + @psl.fiscalyear_ids
			@psl.user = @ssl.user
			@psl.update_attributes(@params[:productserviceline])
		end

	end	

end
