class EventSponsor < ActiveRecord::Base
  belongs_to :event
  belongs_to :sponsor

  validates :event_id, :presence => true
  validates :sponsor_id, :presence => true, :uniqueness => { :scope => :event_id }
end
