class Sponsor < ActiveRecord::Base
  belongs_to :sponsorable, :polymorphic => true

  attr_accessible :sponsor_name, :subscriptionsourceID, :contentsourceID, :status, :hide, :sponsorURL, :logo_type, :pictures_attributes, :sponsor_type

  before_create :set_flds

  name_regex = 	/^[A-Z]'?['-., a-zA-Z]+$/i
  text_regex = /^[-\w\,. _\/&@]+$/i
  url_regex = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix

  validates :sponsor_name, :allow_blank => true, :format => { :with => name_regex }
  validates :sponsor_type, :presence => true, :unless => "sponsor_name.blank?", :format => { :with => text_regex }
  validates :sponsorURL, :presence => true, :unless => "sponsor_name.blank?", :format => { :with => url_regex }
  validates :logo_type, :unless => "sponsor_name.blank?", :presence => true

  has_many :pictures, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  def set_flds
    self.status = 'active'
    self.hide = 'no'
  end
end
