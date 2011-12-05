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

  def check_avail(slist, start_dt, end_dt)
    avail = {}
    (start_dt..end_dt).each do |dt|
      avail[dt] ||= {}

      # check times from 8am to 8pm
      (8..20).each do |tm|
        avail[dt][tm] ||= 0
	new_dt = merge_times(dt, tm)

        # loop thru subscriber list
        slist.each do |s|

          #check each user's scheduled & private events for availability
          avail[dt][tm] += 1 if time_taken?(s.user.host_profiles[0].scheduled_events, new_dt)
          avail[dt][tm] += 1 if time_taken?(s.user.host_profiles[0].private_events, new_dt)
        end	    

	# calculate percent availability
	avail[dt][tm] *= 100 / slist.count.to_f
      end
    end
    avail
  end
end
