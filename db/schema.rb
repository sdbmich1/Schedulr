# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120111075202) do

  create_table "ads", :force => true do |t|
    t.string   "ad_name"
    t.string   "ad_type"
    t.datetime "startdate"
    t.time     "starttime"
    t.datetime "enddate"
    t.time     "endtime"
    t.string   "contentsourceID"
    t.string   "subscriptionsourceID"
    t.string   "status"
    t.string   "hide"
    t.integer  "sortkey"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "code"
    t.string   "description"
    t.string   "status"
    t.string   "hide"
    t.integer  "sortkey"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_interests", :force => true do |t|
    t.integer  "category_id"
    t.integer  "interest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channel_categories", :force => true do |t|
    t.integer  "channel_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channel_interests", :force => true do |t|
    t.integer  "channel_id",  :null => false
    t.integer  "interest_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  create_table "channel_locations", :force => true do |t|
    t.integer  "location_id"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "channel_locations", ["location_id", "channel_id"], :name => "index_channel_locations_on_location_id"

  create_table "channels", :force => true do |t|
    t.string   "channelID",                            :null => false
    t.integer  "HostProfileID",                        :null => false
    t.string   "channel_name"
    t.string   "channel_title"
    t.string   "channel_class"
    t.string   "channel_type"
    t.text     "cbody"
    t.string   "bbody"
    t.string   "status"
    t.string   "hide"
    t.integer  "sortkey"
    t.string   "subscriptionsourceID"
    t.string   "subscriptionsourceURL"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
    t.string   "mapplacename"
    t.string   "mapcity",               :limit => 80
    t.string   "mapstreet"
    t.string   "mapzip",                :limit => 20
    t.string   "mapcountry",            :limit => 100
    t.string   "mapstate",              :limit => 4
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_details", :force => true do |t|
    t.string   "mapcity"
    t.string   "mapstreet"
    t.string   "mapstate"
    t.string   "mapzip"
    t.string   "mapplacename"
    t.string   "work_phone"
    t.string   "home_phone"
    t.string   "mobile_phone"
    t.string   "work_email"
    t.string   "email_address"
    t.string   "facebook_name"
    t.string   "twitter_name"
    t.string   "linkedin_name"
    t.integer  "contactable_id"
    t.integer  "polymorphic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contactable_type"
    t.string   "website"
    t.string   "skype_name"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entity_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_presenters", :force => true do |t|
    t.integer  "event_id"
    t.integer  "presenter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "eventid"
  end

  add_index "event_presenters", ["event_id", "presenter_id"], :name => "index_event_presenters_on_event_id_and_presenter_id", :unique => true
  add_index "event_presenters", ["event_id"], :name => "index_event_presenters_on_event_id"
  add_index "event_presenters", ["eventid"], :name => "index_event_presenters_on_eventid"
  add_index "event_presenters", ["presenter_id"], :name => "index_event_presenters_on_presenter_id"

  create_table "event_sites", :force => true do |t|
    t.string   "name"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "event_sponsor_pages", :force => true do |t|
    t.integer  "event_id"
    t.integer  "sponsor_page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_sponsors", :force => true do |t|
    t.integer  "event_id"
    t.integer  "sponsor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_tracks", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_types", :force => true do |t|
    t.string   "code"
    t.string   "status"
    t.string   "hide"
    t.integer  "sortkey"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "events", :primary_key => "ID", :force => true do |t|
    t.string   "event_name"
    t.string   "event_type"
    t.text     "cbody"
    t.string   "bbody"
    t.datetime "eventstartdate"
    t.datetime "eventenddate"
    t.float    "localGMToffset"
    t.float    "endGMToffset"
    t.string   "mapstreet"
    t.string   "mapcity"
    t.string   "mapstate"
    t.string   "mapzip"
    t.string   "mapplacename"
    t.string   "mapcountry"
    t.string   "location"
    t.string   "imagelink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "hide"
    t.string   "session_type"
    t.string   "event_title"
    t.string   "RSVPemail"
    t.string   "contentsourceID"
    t.string   "subscriptionsourceID"
    t.string   "host"
    t.string   "eventid"
    t.string   "speaker"
    t.string   "speakertopic"
    t.string   "rsvp"
    t.string   "track"
    t.datetime "eventstarttime"
    t.datetime "eventendtime"
    t.decimal  "MemberFee",                           :precision => 19, :scale => 2
    t.decimal  "NonMemberFee",                        :precision => 19, :scale => 2
    t.decimal  "AffiliateFee",                        :precision => 19, :scale => 2
    t.decimal  "SpouseFee",                           :precision => 19, :scale => 2
    t.decimal  "GroupFee",                            :precision => 19, :scale => 2
    t.decimal  "AtDoorFee",                           :precision => 19, :scale => 2
    t.decimal  "Other1Fee",                           :precision => 19, :scale => 2
    t.decimal  "Other2Fee",                           :precision => 19, :scale => 2
    t.decimal  "Other3Fee",                           :precision => 19, :scale => 2
    t.decimal  "Other4Fee",                           :precision => 19, :scale => 2
    t.decimal  "Other5Fee",                           :precision => 19, :scale => 2
    t.decimal  "Other6Fee",                           :precision => 19, :scale => 2
    t.string   "contentsourceURL"
    t.string   "subscriptionsourceURL"
    t.string   "Other1Title",           :limit => 50
    t.string   "Other2Title",           :limit => 50
    t.string   "Other3Title",           :limit => 50
    t.string   "Other4Title",           :limit => 50
    t.string   "Other5Title",           :limit => 50
    t.string   "Other6Title",           :limit => 50
  end

  add_index "events", ["eventid"], :name => "index_events_on_eventid"
  add_index "events", ["eventstartdate", "eventenddate"], :name => "index_events_on_eventstartdate_and_eventenddate"
  add_index "events", ["subscriptionsourceID", "contentsourceID"], :name => "ssid_idx"

  create_table "eventstsd", :primary_key => "ID", :force => true do |t|
    t.string   "eventid",               :limit => 20
    t.string   "parenteventid",         :limit => 20
    t.string   "event_name",            :limit => 100
    t.string   "event_title",           :limit => 200
    t.string   "event_type",            :limit => 20
    t.datetime "eventstartdate"
    t.datetime "eventenddate"
    t.datetime "eventstarttime"
    t.datetime "eventendtime"
    t.string   "AllDay",                :limit => 5
    t.float    "localGMToffset"
    t.float    "endGMToffset"
    t.string   "location"
    t.datetime "postdate"
    t.string   "cformat",               :limit => 10
    t.string   "speaker",               :limit => 100
    t.string   "speakertopic"
    t.string   "host",                  :limit => 100
    t.text     "cbody",                 :limit => 2147483647
    t.text     "bbody",                 :limit => 2147483647
    t.string   "agendaID",              :limit => 50
    t.string   "minutesID",             :limit => 50
    t.string   "MembershipType",        :limit => 20
    t.string   "Committee",             :limit => 20
    t.string   "rsvp",                  :limit => 50
    t.string   "RSVPemail",             :limit => 50
    t.string   "imageID",               :limit => 50
    t.string   "imagetitle",            :limit => 50
    t.string   "imagecaption",          :limit => 100
    t.string   "pdfFilename",           :limit => 50
    t.string   "imagelink",             :limit => 50
    t.string   "fundraiser",            :limit => 50
    t.string   "progserv",              :limit => 5
    t.string   "prodserv",              :limit => 5
    t.string   "profserv",              :limit => 5
    t.string   "listID",                :limit => 20
    t.string   "coordinatorID",         :limit => 50
    t.string   "notice1send",           :limit => 5
    t.string   "notice2send",           :limit => 5
    t.datetime "expirationdate"
    t.decimal  "MemberFee",                                   :precision => 19, :scale => 2
    t.decimal  "SpouseFee",                                   :precision => 19, :scale => 2
    t.decimal  "NonMemberFee",                                :precision => 19, :scale => 2
    t.decimal  "AtDoorFee",                                   :precision => 19, :scale => 2
    t.decimal  "GroupFee",                                    :precision => 19, :scale => 2
    t.decimal  "AffiliateFee",                                :precision => 19, :scale => 2
    t.datetime "LateFeeDate"
    t.decimal  "LateMemberFee",                               :precision => 19, :scale => 2
    t.decimal  "LateSpouseFee",                               :precision => 19, :scale => 2
    t.decimal  "LateNonMemberFee",                            :precision => 19, :scale => 2
    t.decimal  "LateGroupFee",                                :precision => 19, :scale => 2
    t.decimal  "LateAffiliateFee",                            :precision => 19, :scale => 2
    t.string   "Other1Title",           :limit => 50
    t.decimal  "Other1Fee",                                   :precision => 19, :scale => 2
    t.string   "Other2Title",           :limit => 50
    t.decimal  "Other2Fee",                                   :precision => 19, :scale => 2
    t.string   "Other3Title",           :limit => 50
    t.decimal  "Other3Fee",                                   :precision => 19, :scale => 2
    t.string   "Other4Title",           :limit => 50
    t.decimal  "Other4Fee",                                   :precision => 19, :scale => 2
    t.string   "Other5Title",           :limit => 50
    t.decimal  "Other5Fee",                                   :precision => 19, :scale => 2
    t.string   "Other6Title",           :limit => 50
    t.decimal  "Other6Fee",                                   :precision => 19, :scale => 2
    t.string   "GalleryID",             :limit => 50
    t.string   "allowsubscription",     :limit => 3
    t.string   "subscriberentry",       :limit => 3
    t.string   "memberonly",            :limit => 5
    t.string   "hide",                  :limit => 3
    t.string   "status",                :limit => 10
    t.datetime "CreateDateTime"
    t.datetime "LastModifyDateTime"
    t.string   "LastModifyBy",          :limit => 50
    t.string   "image2ID",              :limit => 50
    t.string   "image2title",           :limit => 50
    t.string   "image2caption",         :limit => 100
    t.string   "image2link",            :limit => 50
    t.string   "sponsorlink",           :limit => 100
    t.string   "mapstreet",             :limit => 40
    t.string   "mapcity",               :limit => 40
    t.string   "mapstate",              :limit => 25
    t.string   "mapzip",                :limit => 10
    t.string   "mapcountry",            :limit => 40
    t.string   "mapplacename",          :limit => 60
    t.integer  "reliability"
    t.datetime "globalupdatedatetime"
    t.string   "resvtargetID",          :limit => 50
    t.string   "contentsourceID",       :limit => 50
    t.string   "contentsourceURL",      :limit => 250
    t.string   "subscriptionsourceID",  :limit => 50
    t.string   "subscriptionsourceURL", :limit => 100
    t.string   "sourceURL",             :limit => 250
  end

  create_table "gmttimezones", :id => false, :force => true do |t|
    t.float    "ID"
    t.float    "code"
    t.string   "code2"
    t.string   "DST"
    t.string   "description"
    t.string   "description2"
    t.string   "status"
    t.float    "sortkey"
    t.string   "hide"
    t.datetime "CreateDateTime"
    t.datetime "LastModifyDateTime"
    t.string   "LastModifyBy"
  end

  create_table "host_profile_users", :force => true do |t|
    t.integer  "user_id"
    t.string   "subscriptionsourceID"
    t.string   "access_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "host_profile_users", ["subscriptionsourceID"], :name => "index_host_profile_users_on_subscriptionsourceID"
  add_index "host_profile_users", ["user_id", "subscriptionsourceID"], :name => "index_host_profile_users_on_user_id_and_subscriptionsourceID"
  add_index "host_profile_users", ["user_id"], :name => "index_host_profile_users_on_user_id"

  create_table "host_profiles", :force => true do |t|
    t.string   "hostname"
    t.string   "status"
    t.string   "hide"
    t.integer  "sortkey"
    t.string   "channelID",             :null => false
    t.string   "subscriptionsourceID"
    t.string   "subscriptionsourceURL"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "host_profiles", ["channelID"], :name => "channelID_fkey"

  create_table "hostprofiles", :primary_key => "ID", :force => true do |t|
    t.integer  "ProfileID"
    t.string   "HostChannelID",           :limit => 50
    t.string   "ProfileType",             :limit => 20
    t.string   "EntityType",              :limit => 20
    t.string   "EntityCategory",          :limit => 20
    t.string   "EntitySubcategory1",      :limit => 20
    t.string   "EntitySubcategory2",      :limit => 20
    t.string   "EntitySubcategory3",      :limit => 20
    t.string   "PrivacyLevel",            :limit => 20
    t.string   "PromoAcceptanceLevel",    :limit => 20
    t.string   "ManagementLevel",         :limit => 50
    t.string   "ServiceClass",            :limit => 20
    t.string   "Gender",                  :limit => 10
    t.string   "Class",                   :limit => 4
    t.string   "Prefix_Title",            :limit => 20
    t.string   "LastName",                :limit => 30
    t.string   "MiddleName",              :limit => 20
    t.string   "FirstName",               :limit => 20
    t.string   "Suffix",                  :limit => 25
    t.string   "Nickname",                :limit => 25
    t.string   "FullName",                :limit => 50
    t.string   "HostName",                :limit => 100
    t.string   "SortName",                :limit => 100
    t.string   "Sort_Name_Override",      :limit => 100
    t.string   "Deceased",                :limit => 5
    t.string   "YearofDeath",             :limit => 4
    t.string   "address_status",          :limit => 25
    t.string   "Address1",                :limit => 40
    t.string   "Address2",                :limit => 40
    t.string   "City",                    :limit => 40
    t.string   "State",                   :limit => 25
    t.string   "PostalCode",              :limit => 10
    t.string   "CSZ",                     :limit => 50
    t.string   "Country"
    t.string   "Company"
    t.string   "Title",                   :limit => 60
    t.string   "Phone_Home",              :limit => 50
    t.string   "Phone_Work"
    t.string   "Workextn",                :limit => 4
    t.string   "Phone_cell",              :limit => 50
    t.string   "Phone_Pager"
    t.string   "Phone_Fax"
    t.string   "StartMonth",              :limit => 2
    t.string   "StartDay",                :limit => 2
    t.string   "StartYear",               :limit => 4
    t.datetime "ServiceStartDate"
    t.string   "EMAIL"
    t.string   "email_work"
    t.string   "email_personal"
    t.string   "IMUserID1"
    t.string   "IMservice1",              :limit => 25
    t.string   "IMUserID2"
    t.string   "IMservice2",              :limit => 25
    t.string   "URL"
    t.string   "BoardMember",             :limit => 5
    t.string   "ExecutiveCommittee",      :limit => 5
    t.string   "Officer",                 :limit => 5
    t.string   "ORG0"
    t.string   "ORG1"
    t.string   "ORG2"
    t.string   "ORG3"
    t.string   "ORG4"
    t.string   "ORG5"
    t.string   "ORG6"
    t.string   "ORG7"
    t.string   "ORG8"
    t.string   "ORG9"
    t.string   "Paidup",                  :limit => 5
    t.string   "skill1",                  :limit => 50
    t.string   "skill2",                  :limit => 50
    t.string   "skill3",                  :limit => 50
    t.string   "skill4",                  :limit => 50
    t.string   "skill5",                  :limit => 50
    t.string   "interest1",               :limit => 50
    t.string   "interest2",               :limit => 50
    t.string   "interest3",               :limit => 50
    t.string   "interest4",               :limit => 50
    t.string   "interest5",               :limit => 50
    t.string   "hobby1",                  :limit => 50
    t.string   "hobby2",                  :limit => 50
    t.string   "hobby3",                  :limit => 50
    t.string   "hobby4",                  :limit => 50
    t.string   "hobby5",                  :limit => 50
    t.text     "OrgPurpose"
    t.string   "GrossRevenue",            :limit => 20
    t.string   "EmployeeLevel",           :limit => 20
    t.string   "Industry",                :limit => 20
    t.string   "BusinessClass",           :limit => 20
    t.string   "Ethnicity",               :limit => 20
    t.string   "Ethnic1",                 :limit => 20
    t.string   "Ethnic2",                 :limit => 20
    t.string   "Nationality",             :limit => 20
    t.string   "Religion",                :limit => 20
    t.string   "Religion1",               :limit => 20
    t.string   "Religion2",               :limit => 20
    t.string   "PoliticalAffiliation1",   :limit => 20
    t.string   "PoliticalAffiliation2",   :limit => 20
    t.string   "ArtNMuseumOrg",           :limit => 5
    t.string   "CommunityOrg",            :limit => 5
    t.string   "EducationalInst",         :limit => 5
    t.string   "EntertainmentlInst",      :limit => 5
    t.string   "GovernmentOrg",           :limit => 5
    t.string   "NewsInst",                :limit => 5
    t.string   "PoliticalAssoc",          :limit => 5
    t.string   "ReligiouslInst",          :limit => 5
    t.string   "RetailInst",              :limit => 5
    t.string   "NonRetailBusOrg",         :limit => 5
    t.string   "ServiceOrg",              :limit => 5
    t.string   "TradeAssoc",              :limit => 5
    t.string   "YouthActivitiyOrg",       :limit => 5
    t.string   "OtherOrg",                :limit => 5
    t.string   "bioID",                   :limit => 20
    t.string   "imageid",                 :limit => 50
    t.string   "imagetitle",              :limit => 50
    t.string   "imagecaption",            :limit => 100
    t.string   "thumbnail",               :limit => 50
    t.string   "PrimaryResAddr",          :limit => 50
    t.string   "PrimaryBusAddr",          :limit => 50
    t.string   "BillingAddr",             :limit => 50
    t.string   "ShippingAddr",            :limit => 50
    t.string   "MailingAddr",             :limit => 50
    t.string   "DirectoryAddr",           :limit => 50
    t.integer  "Visitation_counter_1"
    t.integer  "Visitation_counter_2"
    t.integer  "Visitation_counter_3"
    t.string   "hide",                    :limit => 5
    t.string   "status",                  :limit => 10
    t.string   "bademail",                :limit => 5
    t.string   "donotmail",               :limit => 5
    t.string   "donotemail",              :limit => 5
    t.string   "donotsolicit",            :limit => 5
    t.string   "donotemailnewsletters",   :limit => 5
    t.string   "donotemailinvitations",   :limit => 5
    t.string   "donotalert",              :limit => 5
    t.string   "donotcall",               :limit => 5
    t.string   "donotIM",                 :limit => 5
    t.string   "textonlyemail",           :limit => 5
    t.string   "wirelessservice",         :limit => 50
    t.string   "updatewebpage",           :limit => 5
    t.string   "updatecalendar",          :limit => 5
    t.string   "updatevolunteer",         :limit => 5
    t.string   "updateactivity",          :limit => 5
    t.string   "orgmemberID",             :limit => 50
    t.string   "ContactMethodPref",       :limit => 20
    t.string   "contactpermissionlevel",  :limit => 5
    t.datetime "lastKitsAccessDateTime"
    t.datetime "prevKitsAccessDateTime"
    t.string   "Account_Status",          :limit => 50
    t.text     "Comment1"
    t.text     "AdminComment"
    t.string   "LastModifyBy",            :limit => 50
    t.datetime "CreateDateTime"
    t.datetime "LastModifyDateTime"
    t.string   "local1alertchannelid",    :limit => 50
    t.string   "local2alertchannelid",    :limit => 50
    t.string   "local3alertchannelid",    :limit => 50
    t.string   "regional1alertchannelid", :limit => 50
    t.string   "regional2alertchannelid", :limit => 50
    t.string   "regional3alertchannelid", :limit => 50
    t.string   "national1alertchannelid", :limit => 50
    t.string   "national2alertchannelid", :limit => 50
    t.string   "national3alertchannelid", :limit => 50
    t.string   "subscriptionsourceID",    :limit => 50
    t.string   "subscriptionsourceURL",   :limit => 50
    t.string   "promoCode",               :limit => 50
  end

  add_index "hostprofiles", ["ProfileID"], :name => "profileID_idx"
  add_index "hostprofiles", ["subscriptionsourceID"], :name => "ssid_idx"

  create_table "interests", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "sortkey"
    t.string   "status"
    t.string   "hide"
  end

  create_table "interests_users", :id => false, :force => true do |t|
    t.integer "user_id",     :null => false
    t.integer "interest_id", :null => false
  end

  add_index "interests_users", ["user_id", "interest_id"], :name => "int_user_index", :unique => true

  create_table "locations", :force => true do |t|
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logo_types", :force => true do |t|
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",      :limit => 45
    t.string   "hide",        :limit => 45
    t.integer  "sortkey"
    t.string   "logo_size",   :limit => 45
  end

  create_table "pictures", :force => true do |t|
    t.string   "name"
    t.integer  "imageable_id"
    t.integer  "polymorphic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "imageable_type"
  end

  create_table "presenters", :force => true do |t|
    t.string   "name"
    t.text     "bio"
    t.string   "title"
    t.string   "org_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subscriptionsourceID"
    t.string   "contentsourceID"
    t.string   "hide",                 :limit => 45
    t.string   "status",               :limit => 45
    t.integer  "sortkey"
  end

  add_index "presenters", ["subscriptionsourceID", "contentsourceID"], :name => "ssid_idx"

  create_table "promo_codes", :force => true do |t|
    t.string   "code"
    t.string   "promo_name"
    t.text     "description"
    t.datetime "promostartdate"
    t.datetime "promoenddate"
    t.datetime "promostarttime"
    t.datetime "promoendtime"
    t.integer  "promoable_id"
    t.string   "LastUpdatedBy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promotions", :force => true do |t|
    t.string   "name"
    t.string   "promo_type"
    t.date     "start_date"
    t.date     "end_date"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "event_id"
    t.text     "description"
    t.float    "promo_fee"
    t.integer  "sponsor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reminders", :primary_key => "ID", :force => true do |t|
    t.string   "SubscriberID",       :limit => 50
    t.integer  "TSDID"
    t.string   "eventID",            :limit => 20
    t.string   "sourceID",           :limit => 50
    t.string   "sourceURL",          :limit => 250
    t.datetime "eventstartdate"
    t.string   "reminder_type",      :limit => 10
    t.string   "reminder_name",      :limit => 100
    t.string   "remindertext",       :limit => 250
    t.string   "reminderURL",        :limit => 250
    t.datetime "startdate"
    t.datetime "starttime"
    t.datetime "endtime"
    t.string   "AllDay",             :limit => 5
    t.integer  "advwarningdays"
    t.integer  "advwarningminutes"
    t.string   "hide",               :limit => 5
    t.string   "status",             :limit => 10
    t.datetime "CreateDateTime"
    t.datetime "LastModifyDateTime"
    t.string   "LastModifyBy",       :limit => 50
  end

  create_table "rsvps", :primary_key => "ID", :force => true do |t|
    t.string   "EventID",                  :limit => 20
    t.string   "inviteeid",                :limit => 20
    t.string   "inviteesourceID",          :limit => 50
    t.string   "inviterid",                :limit => 20
    t.string   "invitersourceID",          :limit => 50
    t.string   "email",                    :limit => 50
    t.string   "Phone_contact",            :limit => 25
    t.integer  "guests"
    t.datetime "invitedate"
    t.datetime "responsedate"
    t.datetime "arrivaltime"
    t.datetime "arrivaldate"
    t.string   "fullname",                 :limit => 50
    t.string   "sortname",                 :limit => 50
    t.string   "comment",                  :limit => 253
    t.string   "status",                   :limit => 50
    t.string   "attended",                 :limit => 50
    t.string   "guest1name",               :limit => 50
    t.string   "guest2name",               :limit => 50
    t.string   "guest3name",               :limit => 50
    t.string   "guest4name",               :limit => 50
    t.string   "guest5name",               :limit => 50
    t.string   "guest6name",               :limit => 50
    t.string   "guest7name",               :limit => 50
    t.string   "guest8name",               :limit => 50
    t.string   "guest9name",               :limit => 50
    t.string   "guest10name",              :limit => 50
    t.decimal  "TotalRegistrationFeesDue",                :precision => 19, :scale => 2
    t.string   "FeesWaived",               :limit => 50
    t.string   "FeesWaivedReason",         :limit => 10
    t.string   "FeesWaivedComment",        :limit => 253
    t.decimal  "Payment1",                                :precision => 19, :scale => 2
    t.datetime "Payment1DateTime"
    t.decimal  "Payment2",                                :precision => 19, :scale => 2
    t.datetime "Payment2DateTime"
    t.decimal  "Payment3",                                :precision => 19, :scale => 2
    t.datetime "Payment3DateTime"
    t.decimal  "MemberFee",                               :precision => 19, :scale => 2
    t.decimal  "SpouseFee",                               :precision => 19, :scale => 2
    t.decimal  "NonMemberFee",                            :precision => 19, :scale => 2
    t.decimal  "AtDoorFee",                               :precision => 19, :scale => 2
    t.decimal  "LateMemberFee",                           :precision => 19, :scale => 2
    t.decimal  "LateSpouseFee",                           :precision => 19, :scale => 2
    t.decimal  "LateNonMemberFee",                        :precision => 19, :scale => 2
    t.decimal  "Other1Fee",                               :precision => 19, :scale => 2
    t.decimal  "Other2Fee",                               :precision => 19, :scale => 2
    t.decimal  "Other3Fee",                               :precision => 19, :scale => 2
    t.decimal  "Other4Fee",                               :precision => 19, :scale => 2
    t.decimal  "Other5Fee",                               :precision => 19, :scale => 2
    t.decimal  "Other6Fee",                               :precision => 19, :scale => 2
    t.string   "Refunded",                 :limit => 5
    t.float    "credits"
    t.float    "hours"
    t.string   "acknowledged",             :limit => 5
    t.datetime "CreateDateTime"
    t.datetime "LastModifyDateTime"
    t.string   "LastModifyBy",             :limit => 50
    t.string   "DoNotEmail",               :limit => 5
    t.string   "DoNotEmailInvitation",     :limit => 5
    t.string   "TextOnlyEmail",            :limit => 5
    t.string   "subscriptionsourceID",     :limit => 50
    t.string   "subscriptionsourceURL",    :limit => 50
  end

  create_table "session_relationships", :force => true do |t|
    t.integer  "event_id"
    t.integer  "session_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "session_relationships", ["event_id", "session_id"], :name => "index_session_relationships_on_event_id_and_session_id", :unique => true
  add_index "session_relationships", ["event_id"], :name => "index_session_relationships_on_event_id"
  add_index "session_relationships", ["session_id"], :name => "index_session_relationships_on_session_id"

  create_table "session_types", :force => true do |t|
    t.string   "description"
    t.string   "status"
    t.string   "hide"
    t.integer  "sortkey"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code",        :limit => 45
  end

  create_table "sponsor_pages", :force => true do |t|
    t.string   "name"
    t.string   "message"
    t.string   "subscriptionsourceID"
    t.string   "contentsourceID"
    t.string   "status"
    t.string   "hide"
    t.string   "sponsorable_type"
    t.integer  "sponsorable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "sponsors", :force => true do |t|
    t.string   "sponsor_name"
    t.string   "subscriptionsourceID"
    t.string   "contentsourceID"
    t.string   "status"
    t.string   "hide"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sponsorURL"
    t.integer  "sponsorable_id",                     :null => false
    t.string   "sponsorable_type",                   :null => false
    t.string   "sponsor_type"
    t.string   "logo_type",            :limit => 45
  end

  create_table "status_types", :force => true do |t|
    t.string   "code"
    t.string   "description"
    t.string   "hide"
    t.integer  "sortkey"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.string   "channelID"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contentsourceID"
    t.string   "status",          :limit => 45
    t.string   "hide",            :limit => 45
    t.integer  "sortkey"
    t.integer  "channel_id"
  end

  add_index "subscriptions", ["channelID", "contentsourceID"], :name => "channel_csid_idx"
  add_index "subscriptions", ["user_id", "channelID"], :name => "channel_uid_cid_idx", :unique => true

  create_table "transactions", :force => true do |t|
    t.string   "code"
    t.string   "description"
    t.integer  "amt"
    t.string   "currency"
    t.datetime "transaction_date"
    t.string   "channelID"
    t.string   "HostProfileID"
    t.integer  "user_id"
    t.string   "status"
    t.string   "hide"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",       :limit => 50
    t.string   "last_name",        :limit => 60
    t.string   "email",            :limit => 100
    t.string   "BillingAddr",      :limit => 100
    t.string   "City",             :limit => 45
    t.string   "State",            :limit => 2
    t.string   "PostalCode",       :limit => 10
    t.string   "Phone_Home",       :limit => 10
    t.string   "payment_type",     :limit => 20
    t.string   "Phone_Work",       :limit => 10
    t.string   "credit_card_no",   :limit => 20
    t.datetime "expiration_date"
    t.string   "cvv",              :limit => 5
    t.string   "Address2",         :limit => 100
    t.string   "confirmation_no",  :limit => 15
    t.string   "Company"
    t.string   "Country",          :limit => 80
    t.string   "promoCode",        :limit => 45
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
