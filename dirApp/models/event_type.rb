class EventType < ActiveRecord::Base

  scope :unhidden, where(:hide.downcase =>'no')

  default_scope :order => "sortkey ASC"

  def self.active
    unhidden.where(:status.downcase => 'active')
  end

  def self.nonsessions
    active.where("code != 'es'")
  end 

  def desc_title
    description.titleize
  end
end
