class EventPresenter < ActiveRecord::Base
  attr_accessible :event_id, :presenter_id, :eventid

  after_create :add_presenter_to_event
#  before_destroy :remove_presenter_from_event

  belongs_to :event, :foreign_key => :eventid
  belongs_to :presenter

  validates :event_id, :presence => true
  validates :presenter_id, :presence => true, :uniqueness => { :scope => :event_id }

  # get presented by ids
  def self.find_presenter(eid, pid)
    find_by_event_id_and_presenter_id(eid, pid)
  end

  # add presenter to event list if added via a session
  def add_presenter_to_event
    session_event = SessionRelationship.find_by_session_id(self.event_id)
    EventPresenter.find_or_create_by_event_id_and_presenter_id(session_event.event_id, self.presenter_id) unless session_event.blank?
  end

  # delete presenter from event sessions upon delete from event
  def remove_presenter_from_event
    session_event = SessionRelationship.find_by_session_id(self.event_id)
    if session_event.blank?
      Event.find(self.event_id).sessions.each do |s| 
        pstr = EventPresenter.find_by_event_id_and_presenter_id(s.id, self.presenter_id)
	pstr.destroy if pstr
      end
    end
  end
end
