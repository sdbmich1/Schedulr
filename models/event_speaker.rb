class EventSpeaker < ActiveRecord::Base
  attr_accessible :speaker, :title, :bio, :org_name, :event_id, :pictures_attributes, :contact_details_attributes

  belongs_to :event
  belongs_to :event_sessions

  has_many :pictures, :as => :imageable, :dependent => :destroy
  has_many :contact_details, :as => :contactable, :dependent => :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy => true
  accepts_nested_attributes_for :contact_details, :allow_destroy => true
end
