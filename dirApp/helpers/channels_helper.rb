module ChannelsHelper

  def get_category(val)
    Category.find(val).try(:name)
  end

  def get_interest(val)
    Interest.find(val).try(:name)
  end

  def get_age(usr)
    Date.today.year - usr.birth_date.year
  end

  def get_location(usr)
    Location.find(usr.location_id).try(:city)
  end
end
