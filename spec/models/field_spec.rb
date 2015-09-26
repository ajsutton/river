require 'rails_helper'

RSpec.describe Field, type: :model do
  it 'has a valid factory' do
    expect(create(:field)).to be_valid
  end
  
  it 'requires a church' do
    expect(build(:field, church: nil)).to be_invalid
  end
  
  it 'requires applies_to' do
    expect(build(:field, applies_to: nil)).to be_invalid
  end
  
  it 'requires type' do
    expect(build(:field, type: nil)).to be_invalid
  end
  
  it 'defaults required to false' do
    expect(create(:field).required).to be false
  end
end
