class Event < ActiveRecord::Base
  set_primary_key :ID

  attr_accessor :etype
  attr_accessible :etype, :event_name, :event_type, :cbody, :bbody, :eventstartdate, :eventenddate, :eventstarttime, :eventendtime, :localGMToffset, :endGMToffset, :mapstreet, :mapcity, :mapstate, :mapzip, :mapplacename, :mapcountry, :location, :imagelink, :status, :hide, :event_title, :event_tracks_attributes, :pictures_attributes, :speakertopic, :session_type, :track, :event_sites_attributes, :host, :RSVPemail, :created_at, :rsvp, :eventid, :speaker, :updated_at,
  :contentsourceID, :subscriptionsourceID, :event_presenters_attributes

  validates :event_name, :presence => true, :length => { :maximum => 100 }
  validates :event_type, :presence => true
  validates :eventstartdate, :presence => true, :date => {:after_or_equal_to => Date.today}
  validates :eventenddate, :presence => true, :allow_blank => false, :date => {:after_or_equal_to => :eventstartdate}
  validates :eventstarttime, :presence => true
  validates :eventendtime, :presence => true, :allow_blank => false
  validates_time :eventendtime, :after => :eventstarttime, :if => :same_day?
  validates :bbody, :length => { :maximum => 255 }
  validates :location, :presence => true, :if => :is_session?, :unless => :is_break?
  validates :session_type, :presence => true, :if => :is_session?
  
  before_save :set_flds
  after_save :reset_session_data, :unless => "etype.blank?"

  belongs_to :channel, :counter_cache => true 

  has_many :session_relationships, :dependent => :destroy
  has_many :sessions, :through => :session_relationships, :dependent => :destroy

  has_many :event_presenters, :dependent => :destroy
  has_many :presenters, :through => :event_presenters, :dependent => :destroy

  has_many :event_sites, :dependent => :destroy
  has_many :event_tracks, :dependent => :destroy
  has_many :pictures, :as => :imageable, :dependent => :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy => true
  accepts_nested_attributes_for :event_tracks, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :event_sites, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  scope :unhidden, where(:hide.downcase => 'no')
  default_scope :order => 'eventstartdate, eventstarttime ASC'

  def self.active
    unhidden.where(:status.downcase => 'active')
  end

  def self.get_events(page)
    where("event_type != 'es'" ).paginate(:page => page).order('eventstartdate, eventstarttime DESC')
  end

  def is_session?
    event_type == 'es'
  end

  def is_break?
    (%w(wkshp cls mtg key brkout panel).detect { |x| x == session_type }).blank?
  end

  def is_clone?
    etype == 'Clone'
  end

  def same_day?
    eventstartdate == eventenddate
  end

  def set_flds
    self.event_title = self.event_name if self.event_title.blank?
    self.status = 'pending' if self.status.blank?
    self.hide = 'no' if self.hide.blank?
  end

  def reset_session_values
    self.event_name = self.cbody = self.bbody = nil
    self
  end

  protected 

  def reset_session_data

    self.sessions.each do |s|
      ev = Event.find(s.id)

      unless ev.blank?
        ev.eventstartdate = self.eventstartdate
        ev.eventenddate = self.eventenddate
        ev.localGMToffset = self.localGMToffset
        ev.endGMToffset = self.endGMToffset
        ev.mapstreet = self.mapstreet
        ev.mapcity = self.mapcity
        ev.mapstate = self.mapstate
        ev.mapzip = self.mapzip
        ev.mapplacename = self.mapplacename
        ev.save
      end
    end
  end

  def clone_event
    new_event = self.clone

    new_event.status = 'pending'
    new_event.save

    if is_session?
      sr = SessionRelationship.find_by_session_id(self.id)
      Event.find(sr.event_id).session_relationship.create(:session_id => new_event)
    end

    new_event.event_tracks << self.event_tracks.collect { |event_track| event_track.clone } 
    new_event.event_sites << self.event_sites.collect { |event_site| event_site.clone } 
    new_event.event_presenters << self.event_presenters.collect { |event_presenter| event_presenter.clone } 
    new_event.pictures.create(:photo => self.pictures.first.photo) unless new_event.pictures.blank?

    self.sessions.each do |s|
      session_event = Event.create(s.attributes)
      session_event.event_presenters << s.event_presenters.collect { |event_presenter| event_presenter.clone } 
      new_event.session_relationships.create(:session_id => session_event)
    end

    new_event
  end
end
