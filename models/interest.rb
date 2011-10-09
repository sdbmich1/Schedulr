class Interest < KitsDevelopmentModel

  belongs_to :category

  has_many :channel_interests
  has_many :channels, :through => :channel_interests

  has_many :events, :through => :channels
  scope :unhidden, where(:hide.downcase => 'no')

  default_scope :order => 'sortkey ASC'

  def self.get_active_list
    unhidden.where(:status.downcase => 'active')
  end
end
