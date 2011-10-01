class HostProfile < ActiveRecord::Base
  attr_accessible :hostname, :status, :hide, :sortkey, :channelID, :subscriptionsourceID, :subscriptionsourceURL

  has_many :channels
  has_many :events, :through => :channels
end
