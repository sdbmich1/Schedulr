class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel, :foreign_key => :channelID, :primary_key => :channelID

  scope :active, where(:status.downcase => 'active')
  scope :unhidden, where(:hide.downcase => 'no')
end
