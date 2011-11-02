class Presenter < ActiveRecord::Base
  attr_accessible :name, :title, :bio, :org_name, :pictures_attributes, :contact_details_attributes, :subscriptionsourceID, :contentsourceID, 
  		  :hide, :status

  before_create :set_flds

  name_regex = 	/^[A-Z]'?['-., a-zA-Z]+$/i
  text_regex = /^[-\w\,. _\/&@]+$/i

  validates :name, :presence => true, :uniqueness => { :scope => [:org_name, :title] }, :format => { :with => name_regex }
  validates :org_name, :format => { :with => text_regex }
  validates :title, :format => { :with => text_regex }
  validates :bio, :presence => true

  has_many :event_presenters, :dependent => :destroy
  has_many :events, :through => :event_presenters

  has_many :pictures, :as => :imageable, :dependent => :destroy
  has_many :contact_details, :as => :contactable, :dependent => :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy => true
  accepts_nested_attributes_for :contact_details, :allow_destroy => true

  default_scope :order => 'name ASC'
  scope :unhidden, where(:hide.downcase => 'no')

  def self.active
    unhidden.where(:status.downcase => 'active')
  end

  def self.get_channel_list(ssid)
    where("subscriptionsourceID = ?", ssid)
  end

  def self.get_list(page, cid)
    where("contentsourceID = ?", cid).paginate(:page => page)
  end

  def set_flds
    self.status = 'active'
    self.hide = 'no'
  end
end
