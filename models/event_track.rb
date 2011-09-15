class EventTrack < ActiveRecord::Base
  belongs_to :event

  def self.get_track(eid)
    where(:event_id => eid).order(:name)
  end

end
