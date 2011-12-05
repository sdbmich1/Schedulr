require "simple_time_select"
module EventsHelper

  include Avail

  def has_sessions?(etype)
    etype.blank? ? false : (%w(cnf conv fest sem crs trmt).detect { |x| x == etype.downcase})
  end

  def is_clone?(etype)
    etype.blank? ? false : etype == 'Clone' ? true : false
  end

  # parse date ranges
  def get_start_date(start_dt, end_dt, dtype)	  
    if start_dt == end_dt
      if start_dt == Date.today
        @date_s = "Today" 
      else
        dtype == "List" ? @date_s = " #{start_dt.strftime("%D")}" : @date_s = "#{start_dt.strftime("%A, %B %e, %Y")}"
      end
    else
      @date_s = "#{start_dt.strftime("%D")} - #{end_dt.strftime("%D")}" 
    end     
  end

  def rsvp_count(rsvp, rtype)
    rsvp.select {|r| r.status == rtype }.inject(0) {|x,y| x+1 }
  end

  def rsvp?(event)
    event.rsvp.blank? ? false : event.rsvp.downcase == 'yes' ? true : false
  end

  def any_prices?(event)
    %w(AffiliateFee GroupFee MemberFee NonMemberFee AtDoorFee SpouseFee Other1Fee
       Other2Fee Other3Fee Other4Fee Other5Fee Other6Fee).each {
       |method| return true if price_exists?(event,method)
	       }
    false
  end

  def price_exists?(event, method)
    event.send(method).blank? ? false : event.send(method) > 0 ? true : false
  end

  def set_start(stime)
    stime <= 12 ? stime : stime - 12
  end

  def set_end(stime)
    stime < 12 ? stime.to_s + 'AM' : stime == 12 ? stime.to_s + 'PM' : (stime - 12).to_s + 'PM'
  end

end
