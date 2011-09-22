class SessionRelationship < ActiveRecord::Base
  attr_accessible :event_id, :session_id

  belongs_to :event
  belongs_to :session, :class_name => "Event"

#  validates :event_id, :presence => true
#  validates :session_id, :presence => true, :uniqueness => { :scope => :event_id }
end
