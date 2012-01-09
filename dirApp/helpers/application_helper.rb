module ApplicationHelper

  # returns logo or name
  def get_name_or_logo(*args)
    args[0] ? @name = "koncierge.png" : @name = "Kontributor"
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
    args[0].blank? ? '' : args[1].blank? ? args[0].strftime("%D") : args[0].strftime('%m/%d/%Y') 
  end

  def get_nice_time(val)	  
    val.blank? ? '' : val.strftime('%l:%M%p')
  end

  def get_shead(val='span-10')
    mobile_device? ? val : 'span-16'
  end

  def get_mbody
    mobile_device? ? 'span-10' : 'span-16'
  end

  def get_cbody
    mobile_device? ? 'span-8' : 'span-14'
  end

  def get_pbody
    mobile_device? ? 'prepend-2' : 'prepend-6'
  end

  def get_sbody
    mobile_device? ? 'span-12' : 'span-18'
  end

  def get_lbody
    mobile_device? ? 'span-14' : 'span-20'
  end

  def get_layout
    mobile_device? ? "prepend-2 span-14 last" : "prepend-6 span-24 last"
  end
  
  def get_class(*fld)
    fld[0] == 'work_email' || fld[0] == 'work_phone' ? fld[1] > 200 ? 'prepend-4' : 'none' : 'none'
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

  def can_access?
    @user.access_type == 'admin' ? true : false 
  end
end
