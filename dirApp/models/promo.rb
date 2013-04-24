class Promo < KitsCentralModel
  set_primary_key :ID
  before_save :set_flds

  attr_accessor :GroupFee
  attr_accessible :promo_name, :promo_type, :cbody, :bbody, :promostartdate, :promoenddate, :promostarttime, :promoendtime, :localGMToffset, 
  	:endGMToffset, :mapstreet, :mapcity, :mapstate, :mapzip, :mapplacename, :mapcountry, :location, :imagelink, :status, :hide, :promo_title, 
	:pictures_attributes, :speakertopic, :host, :RSVPemail, :rsvp, :promoid, :speaker, :imagecaption, :imagetitle, :expirationdate, :postdate,
  	:contentsourceID, :subscriptionsourceID, :contentsourceURL, :subscriptionsourceURL, :eventID, :event_title,
  	:AffiliateFee, :Other3Fee, :AtDoorFee, :GroupFee, :Other1Fee, :Other2Fee, :SpouseFee, :MemberFee, :NonMemberFee, :Other4Fee, :Other5Fee, 
	:Other6Fee,:Other3Title, :Other1Title, :Other2Title, :Other4Title, :Other5Title, :Other6Title, :promo_codes_attributes

  validates :promo_name, :presence => true, :length => { :maximum => 100 }
  validates :promo_type, :presence => true
  validates :promostartdate, :presence => true, :date => {:after_or_equal_to => Date.today}
  validates :promoenddate, :presence => true, :allow_blank => false, :date => {:after_or_equal_to => :promostartdate}
  validates :promostarttime, :presence => true
  validates :promoendtime, :presence => true, :allow_blank => false
  validates_time :promoendtime, :after => :promostarttime, :if => :same_day?
  validates :bbody, :allow_blank => true, :length => { :maximum => 255 }

  money_regex = /^\$?(?:\d+)(?:.\d{1,2}){0,1}$/
  validates :MemberFee, :allow_blank => true, :format => { :with => money_regex }
  validates :NonMemberFee, :allow_blank => true, :format => { :with => money_regex }
  validates :AffiliateFee, :allow_blank => true, :format => { :with => money_regex }
  validates :AtDoorFee, :allow_blank => true, :format => { :with => money_regex }
  validates :Other1Fee, :allow_blank => true, :format => { :with => money_regex }
  validates :Other2Fee, :allow_blank => true, :format => { :with => money_regex }
  validates :Other3Fee, :allow_blank => true, :format => { :with => money_regex }
  validates :Other4Fee, :allow_blank => true, :format => { :with => money_regex }
  validates :Other5Fee, :allow_blank => true, :format => { :with => money_regex }
  validates :Other6Fee, :allow_blank => true, :format => { :with => money_regex }
  validates :SpouseFee, :allow_blank => true, :format => { :with => money_regex }
  validates :Other1Title, :presence => true, :unless => Proc.new { |a| a.Other1Fee.blank? }
  validates :Other2Title, :presence => true, :unless => Proc.new { |a| a.Other2Fee.blank? }
  validates :Other3Title, :presence => true, :unless => Proc.new { |a| a.Other3Fee.blank? }
  validates :Other4Title, :presence => true, :unless => Proc.new { |a| a.Other4Fee.blank? }
  validates :Other5Title, :presence => true, :unless => Proc.new { |a| a.Other5Fee.blank? }
  validates :Other6Title, :presence => true, :unless => Proc.new { |a| a.Other6Fee.blank? }

  has_many :pictures, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  has_many :promo_codes, :as => :promoable, :dependent => :destroy
  accepts_nested_attributes_for :promo_codes, :allow_destroy => true

  scope :unhidden, where(:hide.downcase => 'no')
  default_scope :order => 'promostartdate, promostarttime ASC'

  def self.active
    unhidden.where(:status.downcase => 'active')
  end

  def same_day?
    promostartdate == promoenddate
  end

  def set_flds
    self.promo_title = self.promo_name
    self.bbody = self.cbody[0..99]
    self.status = 'active' if self.status.blank?
    self.hide = 'no' if self.hide.blank?
    self.promoid = self.promo_type[0..1] + Time.now.to_i.to_s if self.promoid.blank?
  end

  def self.find_promos(page, ssid)
    unscoped.where("promo_type != 'es' AND subscriptionsourceID = ?", ssid).paginate(:page => page, :per_page=> 15).order('promostartdate, promostarttime DESC')
  end

  def self.get_list(page, event)
    where("eventID = ?", event.ID).paginate(:page => page)
  end

end

