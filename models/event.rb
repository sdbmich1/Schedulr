class Event < ActiveRecord::Base
  attr_accessible :event_name, :event_type, :cbody, :bbody, :eventstartdate, :eventenddate, :eventstarttime, :eventendtime, :localGMToffset, :endGMToffset, :mapstreet, :mapcity, :mapstate, :mapzip, :mapplacename, :mapcountry, :location, :imagelink, :status, :hide, :event_title, :event_tracks_attributes, :pictures_attributes, :presenters_attributes, :speakertopic, :session_type, :track, :event_sites_attributes

  before_save :set_flds

  has_many :session_relationships, :dependent => :destroy
  has_many :sessions, :through => :session_relationships

#  has_many :event_sessions, :dependent => :destroy
  has_many :event_presenters, :dependent => :destroy
  has_many :presenters, :through => :event_presenters

  has_many :event_sites, :dependent => :destroy
  has_many :event_tracks, :dependent => :destroy
  has_many :pictures, :as => :imageable, :dependent => :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy => true
  accepts_nested_attributes_for :event_tracks, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :event_sites, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
#  accepts_nested_attributes_for :presenters, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  scope :unhidden, where(:hide.downcase => 'no')

  def self.active
    unhidden.where(:status.downcase => 'active')
  end

  def self.get_conferences
    active.where(:event_type.downcase => 'conf')
  end

  def set_flds
    self.event_title = self.event_name if self.event_title.blank?
    self.status = 'active' if self.status.blank?
    self.hide = 'no' if self.hide.blank?

    self.event_type = 'se' unless self.session_type.blank?
    self.eventstarttime = self.eventstarttime.advance(:hours => self.localGMToffset)
    self.eventendtime = self.eventendtime.advance(:hours => self.endGMToffset)
  end
end
