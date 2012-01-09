module ProcessNotice
 
  def process_notice(model, ptype)
    
    # get profile info
    channel = Channel.find_ssid(model.ssid)
    
    # get trackers based on type    
    channel.subscriptions.each do |sub|
      post_notice(model, sub.user, ptype) unless sub.user.blank? 
    end
  end
    
  def key_field?(fld)
    (%w(eventstartdate eventenddate eventstarttime).detect { |x| x == fld})
  end
    
  def post_notice(model, usr, ptype)
    enotice = EventNotice.create(:eventid=>model.eventid, :event_name=>model.event_name, :event_type=>model.event_type,
            :eventstartdate=>model.eventstartdate, :eventenddate=>model.eventenddate, :Notice_Type=>get_notice_type(model, ptype),
            :Notice_Text=>get_notice_text(model, ptype), :eventstarttime=>model.eventstarttime, :eventendtime=>model.eventendtime,
            :sourceID=>usr.ssid, :subscriberID=>model.ssid, :Notice_ID=>get_notice_id(model), :location=>get_location(model),
            :event_id=>get_event_id(model) )
      
    #also send email to each person
    UserMailer.send_notice(usr.email, enotice, usr).deliver unless usr.email.blank? 
  end
  
  def notification?(model)
    model.class.to_s == "Notification" 
  end
  
  def get_notice_type(model, ptype)
    notification?(model) ? model.Notice_Type : ptype == 'new'? 'schedule' : 'reschedule'
  end
  
  def get_notice_text(model, ptype)
    notification?(model) ? model.Notice_Text : NoticeType.get_description(get_notice_type(model, ptype)) 
  end
  
  def get_notice_id(model)
    notification?(model) ? model.Notice_ID : model.eventid    
  end
  
  def get_event_id(model)
    notification?(model) ? model.event_id : model.ID 
  end

  def get_location(model)
    notification?(model) ? model.location : model.location_details
  end  
end
