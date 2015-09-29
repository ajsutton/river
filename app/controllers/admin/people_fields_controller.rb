# -*- encoding : utf-8 -*-
class Admin::PeopleFieldsController < ApplicationController
  
  def show
    @fields = custom_fields
  end
  
  def update
    parse_fields params
    if @fields.save
      redirect_to admin_people_fields_path
    else
      render "show"
    end
  end

  private
  def parse_fields(params)
    @fields = custom_fields
    @fields.fields = (params[:fields] || []).map do |field_options|
      {
        id: field_options[:id].blank? ? SecureRandom.uuid : field_options[:id],
        name: field_options[:name], 
        type: field_options[:type], 
        required: !!field_options[:required]
      }
    end
    @fields.fields = @fields.fields.reject { |field| field[:name].blank? }
  end
  
  def custom_fields
    options = { applies_to: 'person', church: current_user.church }
    CustomField.find_by(options) || CustomField.new(options)
  end
end
