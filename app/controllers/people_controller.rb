# -*- encoding : utf-8 -*-
class PeopleController < ApplicationController
  before_action :require_church!

  def index
    @people = Person.where(church: current_user.church).page(params[:page])
    @views = View.where(church: current_user.church, applies_to: 'person')
    @current_view = View.find_by(id: params[:view]) || @views.first || View.new(church: current_user.church, applies_to: 'person')
  end

  def new
    @person = Person.new(church: current_user.church)
  end

  def create
    @person = Person.new(person_params)
    @person.church = current_user.church
    @person.fields = fields_to_json(@person.field_definitions, params[:fields])
    if @person.save
      redirect_to people_path
    else
      render 'new'
    end
  end

  def edit
    @person = find(params[:id])
    if (!@person)
      not_found
    end
  end

  def update
    @person = find(params[:id])
    if !@person then
      not_found
    else
      @person.fields = fields_to_json(@person.field_definitions, params[:fields])
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
end
