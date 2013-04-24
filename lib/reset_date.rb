module ResetDate

  def parse_date(old_dt)
    sdate = old_dt.to_s.split('/')
    new_dt = Date.parse(sdate.last + '-' + sdate.first + '-' + sdate.second)    
  end   

  def reset_dates(val)
    if val[:"eventstarttime(5i)"]
      val[:eventstarttime] = val[:"eventstarttime(5i)"]
      val.delete(:"eventstarttime(5i)")
    end

    if val[:"eventendtime(5i)"]
      val[:eventendtime] = val[:"eventendtime(5i)"]
      val.delete(:"eventendtime(5i)")
    end

    if val[:"promo_codes_attributes"]["0"]
      item = val[:"promo_codes_attributes"]["0"]

      if item["promostarttime(5i)"]
        item[:promostarttime] = item["promostarttime(5i)"]
        item.delete(:"promostarttime(5i)")
      end

      if item[:"promoendtime(5i)"]
        item[:promoendtime] = item[:"promoendtime(5i)"]
        item.delete(:"promoendtime(5i)")
      end

      item[:promostartdate] = parse_date(item[:promostartdate]) if item[:promostartdate] 
      item[:promoenddate] = parse_date(item[:promoenddate]) if item[:promoenddate]
    end

    val[:promostartdate] = parse_date(val[:promostartdate]) if val[:promostartdate] 
    val[:promoenddate] = parse_date(val[:promoenddate]) if val[:promoenddate]

    val[:eventstartdate] = parse_date(val[:eventstartdate]) if val[:eventstartdate] 
    val[:eventenddate] = parse_date(val[:eventenddate]) if val[:eventenddate]
    val
  end
end
