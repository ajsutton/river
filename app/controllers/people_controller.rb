class PeopleController < ApplicationController
  before_action :require_church!
  
  def index
    @people = Person.where(church: current_user.church)
  end
  
  def new
    @person = Person.new
  end
  
  def create
    @person = Person.new(person_params)
    @person.church = current_user.church
    if @person.save
      redirect_to people_path
    else
      render 'new'
    end
  end
  
  def edit
    @person = Person.find(params[:id])
  end
  
  def update
    @person = Person.find(params[:id])
    if @person.update(person_params)
      redirect_to people_path
    else
      render 'edit'
    end
  end
  
  private
    def person_params
      params.require(:person).permit(:first_name, :last_name)
    end
end