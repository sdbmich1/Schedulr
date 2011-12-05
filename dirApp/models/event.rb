class Event < ActiveRecord::Base
#  set_table_name 'eventstsd'
  set_primary_key :ID

  attr_accessor :etype
  attr_accessible :etype, :event_name, :event_type, :cbody, :bbody, :eventstartdate, :eventenddate, :eventstarttime, :eventendtime, :localGMToffset, :endGMToffset, :mapstreet, :mapcity, :mapstate, :mapzip, :mapplacename, :mapcountry, :location, :imagelink, :status, :hide, :event_title, :event_tracks_attributes, :pictures_attributes, :speakertopic, :session_type, :track, :event_sites_attributes, :host, :RSVPemail, :created_at, :rsvp, :eventid, :speaker, :updated_at,
  :contentsourceID, :subscriptionsourceID, :event_presenters_attributes, :contentsourceURL, :subscriptionsourceURL, 
  :AffiliateFee, :Other3Fee, :AtDoorFee, :GroupFee, :Other1Fee, :Other2Fee, :SpouseFee, :MemberFee, :NonMemberFee, :Other4Fee, :Other5Fee, :Other6Fee,:Other3Title, :Other1Title, :Other2Title, :Other4Title, :Other5Title, :Other6Title

  money_regex = /^\$?(?:\d+)(?:.\d{1,2}){0,1}$/
  url_regex = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix

  validates :event_name, :presence => true, :length => { :maximum => 100 }
  validates :event_type, :presence => true
  validates :eventstartdate, :presence => true, :date => {:after_or_equal_to => Date.today}
  validates :eventenddate, :presence => true, :allow_blank => false, :date => {:after_or_equal_to => :eventstartdate}
  validates :eventstarttime, :presence => true
  validates :eventendtime, :presence => true, :allow_blank => false
  validates_time :eventendtime, :after => :eventstarttime, :if => :same_day?
  validates :speakertopic, :allow_blank => true, :length => { :maximum => 100 }
  validates :bbody, :allow_blank => true, :length => { :maximum => 255 }
  validates :location, :presence => true, :if => :is_session?, :unless => :is_break?
  validates :session_type, :presence => true, :if => :is_session?
  validates :MemberFee, :allow_blank => true, :format => { :with => money_regex }
  validates :NonMemberFee, :allow_blank => true, :format => { :with => money_regex }
  validates :AffiliateFee, :allow_blank => true, :format => { :with => money_regex }
  validates :AtDoorFee, :allow_blank => true, :format => { :with => money_regex }
  validates :GroupFee, :allow_blank => true, :format => { :with => money_regex }
  validates :Other1Fee, :allow_blank => true, :format => { :with => money_regex }
  validates :Other2Fee, :allow_blank => true, :format => { :with => money_regex }
  validates :Other3Fee, :allow_blank => true, :format => { :with => money_regex }
  validates :Other4Fee, :allow_blank => true, :format => { :with => money_regex }
  validates :Other5Fee, :allow_blank => true, :format => { :with => money_regex }
  validates :Other6Fee, :allow_blank => true, :format => { :with => money_regex }
  validates :SpouseFee, :allow_blank => true, :format => { :with => money_regex }
  validates :Other1Title, :presence => true, :unless => Proc.new { |a| a.Other1Fee.blank? }
  validates :Other2Title, :presence => true, :unless => Proc.new { |a| a.Other2Fee.blank? }
  validates :Other3Title, :presence => true, :unless => Proc.new { |a| a.Other3Fee.blank? }
  validates :Other4Title, :presence => true, :unless => Proc.new { |a| a.Other4Fee.blank? }
  validates :Other5Title, :presence => true, :unless => Proc.new { |a| a.Other5Fee.blank? }
  validates :Other6Title, :presence => true, :unless => Proc.new { |a| a.Other6Fee.blank? }
  
  before_save :set_flds
  after_save :reset_session_data, :unless => "etype.blank?"

  belongs_to :channel

  has_many :session_relationships, :dependent => :destroy
  has_many :sessions, :through => :session_relationships, :dependent => :destroy

  has_many :event_presenters, :dependent => :destroy
  has_many :presenters, :through => :event_presenters, :dependent => :destroy

  has_many :event_sites, :dependent => :destroy
  has_many :event_tracks, :dependent => :destroy
  has_many :rsvps, :dependent => :destroy, :primary_key=>:eventid, :foreign_key => :EventID

  has_many :pictures, :as => :imageable, :dependent => :destroy
  has_many :sponsor_pages, :dependent => :destroy #, :foreign_key => :subscriptionsourceID, :primary_key => :subscriptionsourceID

  accepts_nested_attributes_for :pictures, :allow_destroy => true
  accepts_nested_attributes_for :event_tracks, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :event_sites, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  scope :unhidden, where(:hide.downcase => 'no')
  default_scope :order => 'eventstartdate, eventstarttime ASC'

  def self.active
    unhidden.where(:status.downcase => 'active')
  end

  def self.get_events(page)
    unscoped.where("event_type != 'es' " ).paginate(:page => page).order('eventstartdate, eventstarttime DESC')
  end

  def self.find_events(page, ssid)
    unscoped.where("event_type != 'es' AND subscriptionsourceID = ?", ssid).paginate(:page => page).order('eventstartdate, eventstarttime DESC')
  end

  def self.new_event
    ev = Event.new(:eventstartdate=>Date.today, :eventenddate=>Date.today)
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
    self.eventid = self.event_type[0..1] + Time.now.to_i.to_s if self.eventid.blank?
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

    new_event.eventstartdate = Date.today if new_event.eventstartdate < Date.today
    new_event.eventenddate = Date.today if new_event.eventenddate < Date.today
    new_event.status = 'pending'
    new_event.save

    if is_session?
      sr = SessionRelationship.find_by_session_id(self.id)
      Event.find(sr.event_id).session_relationships.create(:session_id => new_event.id) if sr
    end

    new_event.event_tracks << self.event_tracks.collect { |event_track| event_track.clone } 
    new_event.event_sites << self.event_sites.collect { |event_site| event_site.clone } 
    new_event.event_presenters << self.event_presenters.collect { |event_presenter| event_presenter.clone } 
   # new_event.sessions << self.sessions.collect { |session| session.clone } 

    new_event.sponsor_pages << self.sponsor_pages.collect { |sponsor_page| sponsor_page.clone } 
    self.pictures.each do |p|
      new_event.pictures.build(:photo => p.photo)
      new_event.save
    end

    self.sessions.each do |s|
      s.eventstartdate = Date.today if s.eventstartdate < Date.today
      s.eventenddate = Date.today if s.eventenddate < Date.today

      session_event = Event.create(s.attributes)
      session_event.event_presenters << s.event_presenters.collect { |event_presenter| event_presenter.clone } 
      new_event.sessions << session_event
#      new_event.session_relationships.build(:session_id => session_event.id)
      new_event.save
      s.pictures.each do |p|
        session_event.pictures.build(:photo => p.photo)
	session_event.save
      end
    end

    new_event
  end
end
