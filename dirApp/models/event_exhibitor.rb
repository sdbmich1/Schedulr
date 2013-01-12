class EventExhibitor < ActiveRecord::Base
  attr_accessible :event_id, :exhibitor_id, :eventid

  after_create :add_exhibitor_to_event

  belongs_to :event, :foreign_key => :eventid
  belongs_to :exhibitor

  validates :event_id, :presence => true
  validates :exhibitor_id, :presence => true, :uniqueness => { :scope => :event_id }

  # get presented by ids
  def self.find_exhibitor(eid, pid)
    find_by_event_id_and_exhibitor_id(eid, pid)
  end

  # add presenter to event list if added via a session
  def add_exhibitor_to_event
    session_event = SessionRelationship.find_by_session_id(self.event_id)
    EventExhibitor.find_or_create_by_event_id_and_exhibitor_id(session_event.event_id, self.exhibitor_id) unless session_event.blank?
  end

  # delete exhibitor from event sessions upon delete from event
  def remove_exhibitor_from_event
    session_event = SessionRelationship.find_by_session_id(self.event_id)
    if session_event.blank?
      Event.find(self.event_id).sessions.each do |s| 
        pstr = EventExhibitor.find_by_event_id_and_exhibitor_id(s.id, self.exhibitor_id)
	pstr.destroy if pstr
      end
    end
  end
end
