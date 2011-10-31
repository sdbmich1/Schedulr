class StatusType < ActiveRecord::Base

  scope :unhidden, where(:hide.downcase =>'no')

  default_scope :order => "sortkey ASC"
end
