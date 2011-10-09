class ChannelInterest < ActiveRecord::Base

  attr_accessor :category_id, :category_name
  attr_accessible :channel_id, :interest_id, :category_id, :category_name

  belongs_to :channel
  belongs_to :interest

  validates :channel_id, :presence => true
  validates :interest_id, :presence => true, :uniqueness => { :scope => :channel_id }
end
