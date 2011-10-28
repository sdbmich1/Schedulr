class EventSite < ActiveRecord::Base
  attr_accessible :name, :description, :event_id

  validates :name, :presence => true, :unless => 'description.nil?'

  belongs_to :event

  def self.get_list(eid)
    where(:event_id => eid)
  end
end
