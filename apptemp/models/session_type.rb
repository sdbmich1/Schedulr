class SessionType < ActiveRecord::Base

  default_scope :order => 'sortkey ASC'
end
