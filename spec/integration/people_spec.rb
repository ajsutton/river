require 'dsl_helper'

describe 'log in' do
  it 'is forbidden to view index without authentication' do
    Dsl.people.navigate_to_index expect: :forbidden
  end
  
  it 'is forbidden to view index without an associated church' do
    Dsl.home.login :user
    Dsl.people.navigate_to_index expect: :forbidden
  end
end