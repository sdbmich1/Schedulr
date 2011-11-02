module ApplicationHelper

  # returns logo or name
  def get_name_or_logo(*args)
    args[0] ? @name = "koncierge.png" : @name = "Schedulr"
  end

  def title
    base_title = get_name_or_logo
    @title ? base_title : @title
  end

  def chk_offset(*tm)
    #tm[0] = tm[0].advance(:hours => ( tm[1]).to_i) unless tm[1].blank?
    tm[0]
    #tm.blank? ? tm[0].strftime("%l:%M %p") : tm.strftime("%l:%M %p")
  end	

  def chk_image(img)
    img.blank? ? "schedule1.jpg" : img
  end

  def truncate_txt(txt)
    truncate(txt, :length => 40, :omission =>"...")
  end

  def get_event_type(val)
    EventType.find_by_code(val.downcase).try(:description)
  end

  def get_entity_type(val)
    EntityType.find_by_code(val.downcase).try(:description)
  end

  def get_time_zone(val)
    GmtTimezone.find_by_code(val).try(:description)
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

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
