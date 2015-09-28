# -*- encoding : utf-8 -*-
require 'rails_helper'

describe 'people module' do
  it 'is forbidden to view index without authentication' do
    people.navigate_to_index expect: :forbidden
  end
  
  it 'is forbidden to view index without an associated church' do
    home.login :user
    people.navigate_to_index expect: :forbidden
  end
  
  describe 'with a valid church' do
    before :each do
      setup.login_with_church :user, :church
    end
  
    it 'allows adding a person' do
      people.add :person
      people.has_people :person
    end
  
    it 'allows editing a person' do
      people.add :person
      people.edit :person, first_name: 'Roger', last_name: 'Banks'
      people.has_people :person
    end
    
    it 'should not list people from other churches' do
      people.add :person
      people.has_people :person
      
      home.logout
      
      setup.login_with_church :user2, :church2
      people.has_people #none
    end
  end
end

