class PeopleController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @people = Person.find_by(church: current_user.church)
  end
end
