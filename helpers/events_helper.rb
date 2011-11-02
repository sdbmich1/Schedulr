require "simple_time_select"
module EventsHelper

  def has_sessions?(etype)
    etype.blank? ? false : (%w(conf conv fest conc trmt fr).detect { |x| x == etype.downcase})
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
end
