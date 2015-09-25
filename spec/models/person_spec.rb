require 'rails_helper'

describe Person, type: :model do
  it 'should have a valid factory' do
    expect(create(:person)).to be_valid
  end
  
  it 'requires first name' do
    expect(build(:person, first_name: nil)).to be_invalid
  end
  
  it 'requires last name' do
    expect(build(:person, last_name: nil)).to be_invalid
  end
  
  it 'creates a name from first and last names' do
    expect(build(:person, first_name: 'Roger', last_name: 'Smith').name).to eq('Roger Smith')
  end
end
