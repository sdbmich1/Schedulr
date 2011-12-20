module Avail

  def merge_times(dt, tm)
    if tm.class == Fixnum 
      DateTime.new(dt.year, dt.month, dt.day, tm, 0, 0)
    else
      DateTime.new(dt.year, dt.month, dt.day, tm.hour, tm.min, tm.sec)
    end
  end

  def time_taken?(elist, dt)
    elist.detect {|e| (merge_times(e.eventstartdate,e.eventstarttime)..merge_times(e.eventenddate,e.eventendtime)).cover?(dt)}
  end

  def check_avail(slist, val)
    avail = {}
    start_dt = val.to_date
    (start_dt..start_dt+7.days).each do |dt|
      avail[dt] ||= {}

      # check times from 8am to 8pm
      (8..19).each do |tm|
        avail[dt][tm] ||= 0
	new_dt = merge_times(dt, tm)

        # loop thru subscriber list
        slist.each do |s|

          #check each user's scheduled & private events for availability
	  unless s.user.blank?
            avail[dt][tm] += 1 if time_taken?(s.user.profile.scheduled_events, new_dt)
            avail[dt][tm] += 1 if time_taken?(s.user.profile.private_events, new_dt)
	  end
        end	    

	# calculate percent availability
	avail[dt][tm] *= 100 / slist.count.to_f
      end
    end
    avail
  end
end
