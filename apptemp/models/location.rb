class Location < KitsModel
  belongs_to :country

  has_many :channel_locations
  has_many :channels, :through => :channel_locations

  has_many :events, :through => :channels
end
