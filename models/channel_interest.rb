class ChannelInterest < ActiveRecord::Base

  belongs_to :channel, :counter_cache => true
  belongs_to :interest, :counter_cache => true
end
