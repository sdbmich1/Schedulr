class Presenter < ActiveRecord::Base
  attr_accessible :name, :title, :bio, :org_name, :pictures_attributes, :contact_details_attributes

  default_scope :order => 'name ASC'

#  belongs_to :event
  has_many :event_presenters, :dependent => :destroy
  has_many :events, :through => :event_presenters

  has_many :pictures, :as => :imageable, :dependent => :destroy
  has_many :contact_details, :as => :contactable, :dependent => :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy => true
  accepts_nested_attributes_for :contact_details, :allow_destroy => true
end
