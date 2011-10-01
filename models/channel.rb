class Channel < ActiveRecord::Base
  attr_accessible :channelID, :hostprofileID, :channel_name, :channel_title, :channel_class, :channel_type, :cbody, :bbody, :status, :hide, :sortkey, :subscriptionsourceID, :subscriptionsourceURL

  belongs_to :host_profile
  has_many :events,
  	   :finder_sql => proc { "SELECT e.* FROM kitstsddb.events e " +
  	   "INNER JOIN channels c ON c.channelID=e.subscriptionsourceID " +
	   "WHERE c.id=#{id}" }

  has_many :channel_interests
  has_many :interests, :through => :channel_interests
  
  has_many :categories, :through => :interests

  has_many :channel_locations, :dependent => :destroy
  has_many :locations, :through => :channel_locations

end
