class SessionRelationship < ActiveRecord::Base
  belongs_to :event
  belongs_to :session, :class_name => "Event"
end
