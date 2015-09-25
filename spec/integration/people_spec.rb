require 'dsl_helper'

describe 'log in' do
  it 'is forbidden to view index without authentication' do
    Dsl.people.navigate_to_index expect: :forbidden
  end
end