class EventObserver < ActiveRecord::Observer
  include ProcessNotice
  observe :event
  
  def after_create(model)
    process_notice(model, 'new')
  end
  
  def after_update(model)
    model.changes.each do |key, item|
      if key_field?(key) 
        update_scheduled_events(model)
        process_notice(model, 'update'); break
      end
    end
  end

  def update_scheduled_events(model)
    events = ScheduledEvent.where("eventid = ?", model.eventid)
    events.each do |e|
      e.eventstartdate, e.eventstarttime = model.eventstartdate, model.eventstarttime
      e.eventenddate, e.eventendtime = model.eventenddate, model.eventendtime
      e.mapplacename, e.location = model.mapplacename, model.location
      e.mapcity, e.mapstate, e.mapzip = model.mapcity, model.mapstate, model.mapzip
      e.save
    end
  end
  
end
