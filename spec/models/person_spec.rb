require 'rails_helper'

describe Person, type: :model do
  it 'should have a valid factory' do
    expect(build(:person)).to be_valid
  end
  
  it 'requires first name'
  it 'requires last name'
  it 'creates a name from first and last names'
end
