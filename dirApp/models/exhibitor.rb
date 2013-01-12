class Exhibitor < ActiveRecord::Base
  attr_accessible :name, :description, :pictures_attributes, :contact_details_attributes, :contentsourceID, :subscriptionsourceID,
  		  :hide, :status, :location

  before_create :set_flds

  name_regex = 	/^[A-Z]'?['-., a-zA-Z]+$/i
  text_regex = /^[-\w\,. _\/&@]+$/i

  validates :name, :presence => true, :uniqueness => true, :format => { :with => name_regex }
  validates :description, :presence => true #, :format => { :with => text_regex }
  validates :location, :format => { :with => text_regex }

  has_many :event_exhibitors, :dependent => :destroy
  has_many :events, :through => :event_exhibitors

  has_many :pictures, :as => :imageable, :dependent => :destroy
  has_many :contact_details, :as => :contactable, :dependent => :destroy

  has_many :exhibitor_categories
  has_many :interests, :through => :exhibitor_categories
  accepts_nested_attributes_for :exhibitor_categories, :reject_if => lambda { |a| a[:show_category_id].blank? }, :allow_destroy => true

  accepts_nested_attributes_for :pictures, :allow_destroy => true
  accepts_nested_attributes_for :contact_details, :allow_destroy => true

  default_scope :order => 'name ASC'
  scope :unhidden, where(:hide.downcase => 'no')

  def self.active
    unhidden.where(:status.downcase => 'active')
  end

  def set_flds
    self.status = 'active'
    self.hide = 'no'
  end

  def self.get_channel_list(ssid)
    where("subscriptionsourceID = ?", ssid)
  end

  def self.get_list(page, cid)
    where("contentsourceID = ?", cid).paginate(:page => page)
  end

end
