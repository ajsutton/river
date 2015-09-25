require 'dsl_helper'

describe 'people module' do
  it 'is forbidden to view index without authentication' do
    Dsl.people.navigate_to_index expect: :forbidden
  end
  
  it 'is forbidden to view index without an associated church' do
    Dsl.home.login :user
    Dsl.people.navigate_to_index expect: :forbidden
  end
  
  describe 'with a valid church' do
    before :each do
      Dsl.setup.login_with_church :user, :church
    end
  
    it 'allows adding a person' do
      Dsl.people.add :person
      Dsl.people.has_people :person
    end
  
    it 'allows editing a person' do
      Dsl.people.add :person
      Dsl.people.edit :person, first_name: 'Roger', last_name: 'Banks'
      Dsl.people.has_people :person
    end
    
    it 'should not list people from other churches'
    
    it 'should not view people from other churches'
    
    it 'should not edit people from other churches'
  end
end