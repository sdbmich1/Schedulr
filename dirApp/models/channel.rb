class Channel < ActiveRecord::Base
  attr_accessor :category_id
  attr_accessible :channelID, :HostProfileID, :channel_name, :channel_title, :channel_class, :channel_type, 
  		  :cbody, :bbody, :status, :hide, :sortkey, :subscriptionsourceID, :subscriptionsourceURL, 
		  :pictures_attributes, :channel_locations_attributes, :mapcity, :mapstate, :mapzip, :mapstreet, :channel_interests_attributes

  validates :channel_name, :presence => true, :uniqueness => true
  validates :cbody, :presence => true, :on => :update
  validates :bbody, :presence => true, :on => :update

  belongs_to :host_profile, :foreign_key => :HostProfileID
  has_many :events, :foreign_key => :subscriptionsourceID, :primary_key => :channelID #, :dependent => destroy

  has_many :channel_interests
  has_many :interests, :through => :channel_interests
  accepts_nested_attributes_for :channel_interests, :reject_if => lambda { |a| a[:interest_id].blank? }, :allow_destroy => true
  
  has_many :categories, :through => :interests

  has_many :channel_locations, :dependent => :destroy
  has_many :locations, :through => :channel_locations
  accepts_nested_attributes_for :channel_locations, :allow_destroy => true

  has_many :subscriptions, :foreign_key => :channelID, :primary_key => :channelID, :dependent => :destroy, :conditions => "status = 'active'"
  has_many :users, :through => :subscriptions, :source => :user

  has_many :pictures, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  scope :unhidden, where(:hide.downcase => 'no')
  default_scope :order => 'sortkey ASC'

  def self.get_active_list
    unhidden.where(:status.downcase => 'active')
  end

  def self.get_list(hpid)
    get_active_list.where(:HostProfileID => hpid)
  end
end
