class PeopleController < ApplicationController
  before_action :require_church!
  
  def index
    @people = Person.where(church: current_user.church)
  end
end
