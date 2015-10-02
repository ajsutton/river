# -*- encoding : utf-8 -*-
class PeopleController < ApplicationController
  before_action :require_church!

  def index
    @people = Person.where(church: current_user.church).page(params[:page])
    @views = View.where(church: current_user.church, applies_to: 'person')
    @current_view = View.find_by(id: params[:view]) || @views.first || View.new(church: current_user.church, applies_to: 'person')
  end

  def new
    @person = Person.new
    load_custom_fields
  end

  def create
    @person = Person.new(person_params)
    @person.fields = fields_to_json(custom_fields, params[:fields])
    @person.church = current_user.church
    if @person.save
      redirect_to people_path
    else
      load_custom_fields
      render 'new'
    end
  end

  def edit
    @person = find(params[:id])
    if (!@person)
      not_found
    end
    load_custom_fields
  end

  def update
    @person = find(params[:id])
    if !@person then
      not_found
    else
      @person.fields = fields_to_json(custom_fields, params[:fields])
      Rails.logger.info("FOO #{@person.fields}")
      if @person.update(person_params)
        redirect_to people_path
      else
        render 'edit'
      end
    end
  end

  private
    def person_params
      params.require(:person).permit(:first_name, :last_name)
    end

    def find(id)
      Person.find_by({ id: id, church: current_user.church })
    end

    def load_custom_fields
      @fields = custom_fields
    end

    def custom_fields
      schema = CustomField.find_by({ church: current_user.church, applies_to: 'person' })
      schema.nil? ? [] : schema.fields
    end
end
