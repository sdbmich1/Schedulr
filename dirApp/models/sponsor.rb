class Sponsor < ActiveRecord::Base
#  belongs_to :sponsorable, :polymorphic => true

  attr_accessible :sponsor_name, :subscriptionsourceID, :contentsourceID, :status, :hide, :logo_type, :pictures_attributes, :sponsor_type,
  	:contact_details_attributes, :description

  before_create :set_flds

  name_regex = 	/^[A-Z]'?['-., a-zA-Z]+$/i
  text_regex = /^[-\w\,. _\/&@]+$/i
  url_regex = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix

  has_many :event_sponsors, :dependent => :destroy
  has_many :events, :through => :event_sponsors

  validates :sponsor_name, :allow_blank => true, :format => { :with => name_regex }
  validates :sponsor_type, :presence => true, :unless => "sponsor_name.blank?", :format => { :with => text_regex }
  validates :description, :presence => true, :unless => "sponsor_name.blank?" #, :format => { :with => text_regex }
  validates :logo_type, :unless => "sponsor_name.blank?", :presence => true

  has_many :pictures, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  has_many :contact_details, :as => :contactable, :dependent => :destroy
  accepts_nested_attributes_for :contact_details, :allow_destroy => true

  def self.active
    unhidden.where(:status.downcase => 'active')
  end

  def self.get_channel_list(ssid)
    where("subscriptionsourceID = ?", ssid)
  end

  def self.get_list(page, cid)
    where("contentsourceID = ?", cid).paginate(:page => page)
  end

  def details
    description ? description[0..59] : ''
  end

  def descr_length
    description ? description.length : 0
  end

  def set_flds
    self.status = 'active'
    self.hide = 'no'
  end
end
