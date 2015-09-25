class PeopleController < ApplicationController
  before_action :require_church!
  
  def index
    @people = Person.find_by(church: current_user.church)
  end
end
