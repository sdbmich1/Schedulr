class ScheduledEvent < KitsModel
  set_table_name 'events'
  set_primary_key 'ID'
				        
  belongs_to :host_profile
  has_many :pictures, :as => :imageable, :dependent => :destroy
  
  default_scope :order => 'eventstartdate, eventstarttime ASC'
	
  scope :active, where(:status.downcase => 'active')
  scope :unhidden, where(:hide.downcase => 'no')
  
end
