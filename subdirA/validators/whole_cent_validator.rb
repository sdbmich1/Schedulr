class WholeCentValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    _, cents = value.original_value.to_s.gsub(/[^0-9.]/, '').split(".")
    if cents && (cents.length > 2)
      record.errors[attribute] << (options[:message] || "must be a valid dollar value")
    end
  end
end
