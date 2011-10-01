class Interest < KitsDevelopmentModel

  belongs_to :category, :counter_cache => true

  has_many :channel_interests
  has_many :channels, :through => :channel_interests

  has_many :events, :through => :channels
end
