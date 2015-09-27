# -*- encoding : utf-8 -*-
module FieldHelper
  
  def render_field_label(field)
    content_tag(:label, field.name, id: field_id(field))
  end
  
  def render_field(field, model = nil, options = {})
    value = model && model.fields ? model.fields[field.name] : nil
    options[:name] = "#{field.applies_to}[fields[#{field.name}]]"
    options[:id] = field_id field
    options[:value] = value
    case field.data_type
    when 'string'
      options[:type] = 'text'
    when 'integer'
      options[:type] = 'number'
    when 'date'
      options[:type] = 'date'
    when 'boolean'
      options[:type] = 'checkbox'
      options[:value] = nil
      options[:selected] = value ? 'selected' : nil
    else
      throw "Unsupported field type #{field.data_type}"
    end
    tag(:input, options)
  end
  
  private
  
  def field_id(field)
    "#{field.applies_to}_fields_#{field.name}"
  end
end
