module ApplicationHelper

  def chk_offset(*tm)
    #tm[0] = tm[0].advance(:hours => ( tm[1]).to_i) unless tm[1].blank?
    tm[0]
  end	

  def truncate_txt(txt)
    truncate(txt, :length => 40, :omission =>"...")
  end

  def get_event_type(etype)
    ecode = EventType.find_by_code(etype)
    ecode.blank? ? etype : ecode.description
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)  
    new_object = f.object.class.reflect_on_association(association).klass.new  
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|  
      render(association.to_s.singularize + "_fields", :f => builder)  
    end  
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))  
  end 

  def get_nice_date(*args) 
    args[0].blank? ? '' : args[1].blank? ? args[0].strftime("%D") : args[0].strftime('%m-%d-%Y') 
  end

  def get_nice_time(val)	  
    val.blank? ? '' : val.strftime('%l:%M %p')
  end
end
