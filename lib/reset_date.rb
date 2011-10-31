module ResetDate

  def reset_dates(val)
    if val[:"eventstarttime(5i)"]
    val[:eventstarttime] = val[:"eventstarttime(5i)"]
    val.delete(:"eventstarttime(5i)")
    end

    if val[:"eventendtime(5i)"]
    val[:eventendtime] = val[:"eventendtime(5i)"]
    val.delete(:"eventendtime(5i)")
    end
    val
  end
end
