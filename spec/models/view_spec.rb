# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe View, type: :model do

  it 'has a valid factory' do
    expect(create(:view)).to be_valid
  end
  
  it 'requires a church' do
    expect(build(:view, church: nil)).to be_invalid
  end
  
  describe 'applies_to' do
    it 'is required' do
      expect(build(:view, applies_to: nil)).to be_invalid
    end
    
    it 'must be one of the valid values' do
      expect(build(:view, applies_to: 'person')).to be_valid
      expect(build(:view, applies_to: 'churches')).to be_invalid
    end
  end
  
  describe 'name' do
    it 'is required' do
      expect(build(:view, name: nil)).to be_invalid
    end
    
    it 'must be unique within church and applies_to' do
      church = create(:church)
      create(:view, name: 'my view', church: church)
      expect(build(:view, name: 'my view', church: church)).to be_invalid
    end
  end
end
