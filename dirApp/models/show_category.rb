class ShowCategory < ActiveRecord::Base

  scope :unhidden, where(:hide.downcase => 'no')
  default_scope :order => 'sortkey ASC'

  def self.active
    unhidden.where(:status.downcase => 'active')
  end
end
