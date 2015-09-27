# -*- encoding : utf-8 -*-
class PeopleController < ApplicationController
  before_action :require_church!
  
  def index
    @people = Person.where(church: current_user.church)
  end
  
  def new
    @person = Person.new
    load_custom_fields
  end
  
  def create
    @person = Person.new(person_params)
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
    elsif @person.update(person_params)
      redirect_to people_path
    else
      render 'edit'
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
      @fields = Field.where({ church: current_user.church, applies_to: 'person' })
    end
end

