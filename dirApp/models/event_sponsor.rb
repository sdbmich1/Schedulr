class EventSponsor < ActiveRecord::Base
  attr_accessible :event_id, :sponsor_id, :eventid

  after_create :add_sponsor_to_event

  belongs_to :event
  belongs_to :sponsor

  validates :event_id, :presence => true
  validates :sponsor_id, :presence => true, :uniqueness => { :scope => :event_id }

  # get presented by ids
  def self.find_sponsor(eid, pid)
    find_by_event_id_and_sponsor_id(eid, pid)
  end

  # add sponsor to event list if added via a session
  def add_sponsor_to_event
    session_event = SessionRelationship.find_by_session_id(self.event_id)
    EventSponsor.find_or_create_by_event_id_and_sponsor_id(session_event.event_id, self.sponsor_id) unless session_event.blank?
  end

  # delete sponsor from event sessions upon delete from event
  def remove_sponsor_from_event
    session_event = SessionRelationship.find_by_session_id(self.event_id)
    if session_event.blank?
      Event.find(self.event_id).sessions.each do |s| 
        pstr = EventSponsor.find_by_event_id_and_sponsor_id(s.id, self.sponsor_id)
	pstr.destroy if pstr
      end
    end
  end
end
