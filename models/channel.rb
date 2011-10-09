class Channel < ActiveRecord::Base
  attr_accessor :category_id
  attr_accessible :channelID, :HostProfileID, :channel_name, :channel_title, :channel_class, :channel_type, :cbody, :bbody, :status, :hide, :sortkey, :subscriptionsourceID, :subscriptionsourceURL

  belongs_to :host_profile, :foreign_key => :HostProfileID
  has_many :events,
  	   :finder_sql => proc { "SELECT e.* FROM kitstsddb.events e " +
  	   "INNER JOIN channels c ON c.channelID=e.subscriptionsourceID " +
	   "WHERE c.id=#{id}" }

  has_many :channel_interests
  has_many :interests, :through => :channel_interests
  
  has_many :categories, :through => :interests

  has_many :channel_locations, :dependent => :destroy
  has_many :locations, :through => :channel_locations

  has_many :pictures, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  scope :unhidden, where(:hide.downcase => 'no')
  default_scope :order => 'sortkey ASC'

  def self.get_active_list
    unhidden.where(:status.downcase => 'active')
  end
end
