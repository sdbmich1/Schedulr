class SponsorPage < ActiveRecord::Base
  before_create :set_flds

  attr_accessible :name, :message, :subscriptionsourceID, :contentsourceID, :status, :hide, :sponsorable_type, :sponsorable_id, :sponsors_attributes, :event_id

  text_regex = /^[-\w\,. _\/&@]+$/i

  validates :name, :presence => true, :format => { :with => text_regex }
  validates :message, :presence => true, :format => { :with => text_regex }

  belongs_to :event #, :foreign_key => :subscriptionsourceID, :primary_key => :subscriptionsourceID
  has_many :sponsors, :as => :sponsorable, :dependent => :destroy

  accepts_nested_attributes_for :sponsors, :reject_if => lambda { |a| a[:sponsor_name].blank? }, :allow_destroy => true

  default_scope :order => 'name ASC'
  scope :unhidden, where(:hide.downcase => 'no')

  def self.active
    unhidden.where(:status.downcase => 'active')
  end

  def self.get_page_list(ssid)
    active.where("subscriptionsourceID = ?", ssid)
  end
  
  def set_flds
    self.hide = 'no'
  end
end
