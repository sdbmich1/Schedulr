class User < KitsModel
  before_create :set_flds
    
  ACCESS_TYPES = ['admin', 'user']

  # Include default devise modules. Others available are:
  # :token_authenticatable,  :lockable and :timeoutable
  devise :database_authenticatable, :registerable,  #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  # Setup accessible (or protected) attributes for your model - :password_confirmation,
  attr_accessible :email, :password,  :remember_me, :username, :login, :accept_terms,
  				  :first_name, :last_name, :location_id,
  				  :host_profiles_attributes, :localGMToffset, :role
  				  
  # name format validators
  uname_regex = /^[-\w\._@]+$/i
  name_regex = 	/^[A-Z]'?['-., a-zA-Z]+$/i

  # validate added fields  				  
  validates :first_name,  :presence => true,
                    :length   => { :maximum => 30 },
          			:format => { :with => name_regex }  
  validates :last_name,  :presence => true,
                    :length   => { :maximum => 30 },
          			:format => { :with => name_regex }
  validates :username, :presence => true, :uniqueness => true,  
                :allow_blank => true,
          			:length => { :within => 6..30 },
          			:format => { :with => uname_regex }
  validates :location_id, :presence => true
  
  # define channel relationships
  has_many :subscriptions,
           :finder_sql => proc { "SELECT u.* FROM `kits_development`.users u " +
		                 "INNER JOIN `kitsknndb`.subscriptions s ON s.user_id=u.id " +
			         "WHERE s.channelID=#{id}" }

  has_one :host_profile_user
  has_many :host_profiles, :foreign_key => :ProfileID
  accepts_nested_attributes_for :host_profiles, :reject_if => :all_blank 

  has_many :channels, :through => :host_profiles
  has_many :channel_events, :through => :channels

  # Overrides the devise method find_for_authentication
  # Allow users to Sign In using their username or email address
  def self.find_for_authentication(conditions)
    login = conditions.delete(:login)
    where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
  end
  
  def set_flds
    loc = Location.find(self.location_id)
    self.time_zone, self.localGMToffset = loc.time_zone, loc.localGMToffset if loc
  end
  
  def with_host_profile
    self.host_profiles.build if self.host_profiles.empty?
    self
  end

  def profile
    self.host_profiles[0]
  end

  def ssid
    profile.subscriptionsourceID
  end
  
  def pictures
    profile.pictures
  end

  def host_name
    profile.HostName
  end

  def name
    first_name + ' ' + last_name
  end

  def self.get_user(sid)
    HostProfile.get_user(sid)  
  end

  def access_type
    host_profile_user.access_type
  end

  define_index do
    indexes :first_name, :sortable => true
    indexes :last_name, :sortable => true
    indexes [first_name, last_name], :as => :name, :sortable => true

    has :id, :as => :user_id
  end 

end
