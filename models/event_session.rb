class EventSession < ActiveRecord::Base
  attr_accessible :event_name, :event_type, :cbody, :bbody, :eventstartdate, :eventenddate, :eventstarttime, :eventendtime, :localGMToffset, :endGMToffset, :mapstreet, :mapcity, :mapstate, :mapzip, :mapplacename, :mapcountry, :location, :imagelink, :session_type, :event_id, :event_track_id, :status, :hide, :speakertopic, :event_title

  before_save :set_flds

  belongs_to :event
#  has_many :presenters, :through => :event

#  accepts_nested_attributes_for :event_speakers, :reject_if => lambda { |a| a[:speaker].blank? }, :allow_destroy => true

  default_scope :order => 'eventstartdate, eventstarttime ASC'
  scope :unhidden, where(:hide.downcase => 'no')

  def self.active
    unhidden.where(:status.downcase => 'active')
  end

  def set_flds
    self.eventstarttime = self.eventstarttime.advance(:hours => self.localGMToffset)
    self.eventendtime = self.eventendtime.advance(:hours => self.endGMToffset)

    self.session_type == 'mtg' ? self.event_type = 'sm' : self.event_type = 'se'
    self.event_type = 'se' if self.event_type.blank?
    self.status = 'active' if self.status.blank?
    self.hide = 'no' if self.hide.blank?
  end
end
