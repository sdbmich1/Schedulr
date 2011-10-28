class ChannelInterest < ActiveRecord::Base

  attr_accessor :category_name
  attr_accessible :channel_id, :interest_id, :category_id, :category_name

  belongs_to :channel
  belongs_to :interest

  validates :channel_id, :presence => true
  validates :interest_id, :presence => true, :uniqueness => { :scope => :channel_id }, 
  	:unless => Proc.new {|c| c.category_id.blank?}

  validate :any_present?

  def any_present?
    if %w(interest_id).all?{|attr| self[attr].blank?}
      errors.add_to_base("At least one category and subject must be selected")
    end
  end
end
