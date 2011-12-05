class PrivateEvent < KitsDevelopmentModel
  set_table_name 'eventspriv'
  set_primary_key 'ID'
				        
  belongs_to :host_profile
  has_many :pictures, :as => :imageable, :dependent => :destroy
  
  default_scope :order => 'eventstartdate, eventstarttime ASC'
	
end
