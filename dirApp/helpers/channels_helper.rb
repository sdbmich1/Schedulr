module ChannelsHelper

  def get_category(val)
    Category.find(val).try(:name)
  end

  def get_interest(val)
    Interest.find(val).try(:name)
  end
end
