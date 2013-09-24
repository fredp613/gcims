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

	def link_to_add_fields(name, f, association)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.singularize + "_fields", f: builder)
		end
		link_to(name, '#', class: 'add_fields', data: {id: id, fields: fields.gsub("\n", "")})
	end


	def date_picker(name, f, value = "", label="")
		object = f.object.class.name.downcase + "_" + name.to_s
		@name = f.object.class.name.downcase + "[" + name.to_s + "]"
		
	      concat content_tag(:label, label) 
	      content_tag :div, :class=>"controls input-append date" do
	       	concat content_tag :input,"", :class=>"string optional datepicker", 
	       		:id=>object, :name=>@name, :type=>"text", :value=>value.to_date 
		    concat tag(:span, :class=>"add-on icon-calendar") 

   		end
   	end
end




