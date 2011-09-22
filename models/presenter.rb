class Presenter < ActiveRecord::Base
  attr_accessible :name, :title, :bio, :org_name, :pictures_attributes, :contact_details_attributes

  name_regex = 	/^[A-Z]'?[- a-zA-Z]+$/i
  text_regex = /^[-\w\._@]+$/i

  validates :name, :presence => true, :format => { :with => name_regex }
  validates :org_name, :presence => true #, :format => { :with => text_regex }
  validates :title, :format => { :with => name_regex }
  validates :bio, :presence => true

  default_scope :order => 'name ASC'

  has_many :event_presenters, :dependent => :destroy
  has_many :events, :through => :event_presenters

  has_many :pictures, :as => :imageable, :dependent => :destroy
  has_many :contact_details, :as => :contactable, :dependent => :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy => true
  accepts_nested_attributes_for :contact_details, :allow_destroy => true
end
