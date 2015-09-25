require 'dsl_helper'

describe 'people module' do
  it 'is forbidden to view index without authentication' do
    Dsl.people.navigate_to_index expect: :forbidden
  end
  
  it 'is forbidden to view index without an associated church' do
    Dsl.home.login :user
    Dsl.people.navigate_to_index expect: :forbidden
  end
  
  it 'allows adding a person' do
    Dsl.setup.login_with_church :user, :church
    Dsl.people.add :person
    Dsl.people.has_people :person
  end
end