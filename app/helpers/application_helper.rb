module ApplicationHelper
	
	def markdown(content)
	  options = [autolink: true, hard_wrap: true, filter_html: true, safe_links_only: true]
	  @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, *options )
	  @markdown.render(content).html_safe
	end

	def flash_class(type)
	    case type
	        when 'notice' then "alert alert-info"
	        when 'success' then "alert alert-success"
	        when 'error' then "alert alert-error"
	        when 'alert' then "alert alert-error"
	    end
	end


	def bootstrap_flash
	 flash.each do |name, msg|
	    case name.to_s
	    when "notice" then
	      content_tag :div, :id=>'flash', :class => "alert alert-success" do 
	      	concat msg 
	      	concat link
	      end 	       	      	 	      
	    when "alert" then
	      content_tag :div, :id=>'flash', :class => "alert alert-warning" do
	      	concat msg 
	      	concat link
	      end
	    else
	      content_tag :div, :id=>'flash', :class => "alert alert-info" do
	      	concat msg 
	      	concat link
	      end
	    end	 
	  end   			
	end

	def link 
		link_to("#", :class=>"close", "data-dismiss"=>"alert") do 
			"x"
		end
	end

	def link_to_add_fields(name, f, value, association)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.singularize + "_fields", f: builder)
		end
		link_to(name, '#', class: 'add_fields', data: {id: id, fields: fields.gsub("\n", "")})
	end


	# def date_picker(name, f, value, label="", error = "", position="")
	# 	@position = position
	# 	@object = f.object.class.name.downcase
	# 	object = @object + "_" + name.to_s
	# 	@name = f.object.class.name.downcase + "[" + name.to_s + "]"
	# 	if !error.get(name).blank? #used to be !error.empty?
	# 		@error = error.get(name)
	# 		@error_ind = "error"
	# 	else
	# 		@error = ""
	# 		@error_ind = ""
	# 	end
	     	
	# 		#error(@name,object,label) +
	# 	if position !='under'			
	# 		content_tag(:div, :class=>'control-group string required ' + object + ' ' + @error_ind) do
	# 			concat content_tag(:div, :class=>'controls')		 	      	
	# 	      	concat content_tag(:label, label, :class=>"string required control-label", :for=>object)
	# 	      	concat field(@name,object,value,@error, @position) 
	# 	    end
	#   	else
	#      	 field(@name,object,value,@error, @position, @error_ind) 
	     
 #   		end
   		
 #   	end

 #   	def field(name, object,value, error, position, error_indicator)
 #   		   	content_tag(:div, :class=>'control-group string required ' + object + ' ' + error_indicator) do	
	# 	   		content_tag(:div, :class=>'controls') do
	# 	   		 content_tag(:div, :class=>'input-append') do
	# 	     		concat content_tag :input,"", :class=>"string required datepicker", 
	# 	       		:id=>object, :name=>name, :type=>"text",:value=>!value.blank? ? value.to_date : value	       	  	
	# 				@button = "<button class='btn btn-info' style='margin-bottom:5px' type='submit'>
	# 						 <i class='icon-ok'></i>           
	# 						 </button>"
	# 				concat @button.html_safe
	# 				if !(error.blank? || error == "")	       	  				  				 			
	# 		     		concat content_tag(:span, error.first, :class=>'help-inline')			     		 
	# 		     	end
	# 		     	end	
			     			     	
	# 	    	end
		    	
	# 	    end

 #   	end

   	def date_picker(name, f, value, label="", error = "", position="")
		@position = position
		@object = f.object.class.name.downcase
		object = @object + "_" + name.to_s
		@name = f.object.class.name.downcase + "[" + name.to_s + "]"
		if !error.get(name).blank? #used to be !error.empty?
			@error = error.get(name)
			@error_ind = "error"
		else
			@error = ""
			@error_ind = ""
		end

			#error(@name,object,label) +
		if position !='under'			
			content_tag(:div, :class=>'control-group string required ' + object + ' ' + @error_ind) do		 	      	
		      	concat content_tag(:label, label, :class=>"string required control-label", :for=>object)
		      	concat field(@name,object,value,@error, @position) 
		    end
	  	else
	     	 field(@name,object,value,@error, @position) 

   		end
   		
   	end

   	def field(name, object,value, error, position)
   		
   		if position != 'under'
	   		content_tag(:div, :class=>'controls') do
		     		concat content_tag :input,"", :class=>"string required datepicker", 
		       		:id=>object, :name=>name, :type=>"text",:value=>!value.blank? ? value.to_date : value	       	  	
		       	  	if !(error.blank? || error == "")	       	  				  				 			
			     		concat content_tag(:span, error.first, :class=>'help-inline') 
			     	end
	    	end
    	else

    		concat content_tag :input,"", :class=>"string optional datepicker", 
       		:id=>object, :name=>name, :type=>"text",:value=>!value.blank? ? value.to_date : value	       	  	
       	  	if !(error.blank? || error == "")	 
       	  		error.each do |e|       	  				  				 			
	     			concat content_tag(:span, e, :class=>'help-inline') 
	     		end

	     	end
    	end


   	end

  

   	def sortable(object, column, title = nil)
	    title ||= column.titleize
	    if sort_direction == 'asc'
	     css_class = column == sort_column(object) ? "icon-arrow-up small" : nil 
	 	else
	 	 css_class = column == sort_column(object) ? "icon-arrow-down small" : nil 	
	 	end
	    direction = column == sort_column(object) && sort_direction == "asc" ? "desc" : "asc"	    
	    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class} #, :remote=>true}
	end

	

   	
end










