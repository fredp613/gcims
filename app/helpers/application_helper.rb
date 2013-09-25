module ApplicationHelper
	def boostrap_flash(name,msg)
	    case name.to_s
	    when "notice" then
	      content_tag :div, msg, :class => "alert-message success"
	    when "alert" then
	      content_tag :div, msg, :class => "alert-message warning"
	    else
	      content_tag :div, msg, :class => "alert-message info"
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


	def date_picker(name, f, value, label="", error = "")
		
		@object = f.object.class.name.downcase
		object = @object + "_" + name.to_s
		@name = f.object.class.name.downcase + "[" + name.to_s + "]"
		if !error.empty?
			error = error.get(name).first
			error_ind = "error"
		else
			error = ""
			error_ind = ""
		end
	     	
			#error(@name,object,label) +
		content_tag(:div, :class=>'control-group string required ' + object + ' ' + error_ind) do
	      concat content_tag(:label, label, :class=>"string required control-label", :for=>object) 
	     	concat field(@name,object,value,error) 
   		 end
   		
   	end

   	def field(name, object,value, error)
   		content_tag(:div, :class=>'controls') do
	     		concat content_tag :input,"", :class=>"string required datepicker", 
	       		:id=>object, :name=>name, :type=>"text",:value=>!value.blank? ? value.to_date : value
	       	  	
	       	  	if !error.blank?
		     		concat content_tag(:span, error.to_s, :class=>'help-inline') 
		     	end
    	end
   	end

   	
end










