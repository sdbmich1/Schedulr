class Category < KitsDevelopmentModel

  has_many :interests
  has_many :channel_interests, :through => :interests
  has_many :channels, :through => :channel_interests

  has_many :events, :through => :channels

  scope :unhidden, where(:hide.downcase => 'no')
  default_scope :order => 'sortkey ASC'

  def self.get_active_list
    unhidden.where(:status.downcase => 'active')
  end
end
