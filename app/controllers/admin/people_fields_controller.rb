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
    field_update = params[:fields] || []
    @fields = custom_fields
    @fields.fields = field_update.map do |field_options|
      {
        name: field_options[:name], 
        type: field_options[:type], 
        required: !!field_options[:required]
      }
    end
  end
  
  def custom_fields
    options = { applies_to: 'person', church: current_user.church }
    CustomField.find_by(options) || CustomField.new(options)
  end
end
