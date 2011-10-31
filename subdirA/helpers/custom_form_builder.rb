class CustomFormBuilder < ActionView::Helpers::FormBuilder
  def money_field(method, options = {})
    value = @object.send(method)
    if value.try(:original_value)
      formatted_value = value.original_value.presence || value.format
    else
      formatted_value = value.format
    end
    text_field method, options.merge(:value => (formatted_value))
  end
end
