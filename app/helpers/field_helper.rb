# -*- encoding : utf-8 -*-
module FieldHelper
  
  def render_field(field, model = nil)
    value = model && model.fields ? model.fields[field.name] : nil
    name = "#{field.applies_to}[fields[#{field.name}]]"
    id = "#{field.applies_to}_fields_#{field.name}"
    case field.type
    when 'string'
      tag(:input, type: 'text', name: name, id: id, value: value)
    when 'integer'
      tag(:input, type: 'number', name: name, id: id, value: value)
    when 'date'
      tag(:input, type: 'date', name: name, id: id, value: value)
    when 'boolean'
      tag(:input, type: 'checkbox', name: name, id: id, selected: value ? 'selected' : nil)
    else
      throw "Unsupported field type #{field.type}"
    end
  end
  
end

