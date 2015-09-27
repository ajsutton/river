class Admin::PeopleFieldsController < ApplicationController
  
  def show
    @fields = Field.where applies_to: 'person', church: current_user.church
  end
  
  def update
    field_update = params[:fields] || []
    @fields = field_update.map do |field_options|
      Field.new(
        name: field_options[:name], 
        data_type: field_options[:data_type], 
        required: field_options[:required],
        church: current_user.church,
        applies_to: 'person'
      )
    end
#    Field.where(applies_to: 'person', church: current_user.church).delete_all
    if @fields.all? { |field| field.valid? }
    else
      render "show"
    end
  end
end
