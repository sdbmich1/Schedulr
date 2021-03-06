class EventNotice < KitsModel
  before_save :set_flds
  
  attr_accessible :eventid, :event_id, :event_name, :event_type,
                  :eventstartdate, :eventstarttime, :eventenddate, :eventendtime, :Notice_Type, :Notice_Text, 
                  :sourceID, :subscriberID, :Notice_ID, :location, :user_id
                  
  def self.find_notices(sid)
    find_by_sourceID(sid)
  end
  
  def self.get_notices(sid)
    where('sourceID = ?', sid)
  end
  
  def message
    self.Notice_Text.blank? ? '' : self.Notice_Text.titleize 
  end
  
  def title
    self.Notice_Type.blank? ? '' : self.Notice_Type.titleize
  end

  def start_date
    eventstartdate.strftime("%D")
  end
  
  def end_date
    eventenddate.strftime("%D")
  end
  
  def start_time
    eventstarttime.strftime('%l:%M %p')
  end
  
  def end_time
    eventendtime.strftime('%l:%M %p')    
  end

  def set_flds
    self.user_id = User.get_user(self.sourceID).id
    self.status = 'active'
    self.hide = 'no'
  end
end
