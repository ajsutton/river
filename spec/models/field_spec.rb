# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe Field, type: :model do
  it 'has a valid factory' do
    expect(create(:field)).to be_valid
  end
  
  it 'requires a church' do
    expect(build(:field, church: nil)).to be_invalid
  end
  
  describe 'name' do
    it 'is required' do
      expect(build(:field, name: nil)).to be_invalid
    end
    
    it 'must be unique within church and applies_to' do
      church = create(:church)
      create(:field, church: church, applies_to: 'person', name: 'a field')
      expect(build(:field, church: church, applies_to: 'person', name: 'a field')).to be_invalid
    end
  end
  
  describe 'applies_to' do
    it 'is required' do
      expect(build(:field, applies_to: nil)).to be_invalid
    end
    
    it 'must be one of the valid values' do
      expect(build(:field, applies_to: 'person')).to be_valid
      expect(build(:field, applies_to: 'churches')).to be_invalid
    end
  end
  
  describe 'type' do
    it 'is required' do
      expect(build(:field, data_type: nil)).to be_invalid
    end
    
    it 'must be one of the supported values' do
      ['string', 'boolean', 'integer', 'date'].each { |val| expect(build(:field, data_type: val)).to be_valid }
      expect(build(:field, data_type: 'foo')).to be_invalid
    end
  end
  
  it 'defaults required to false' do
    expect(create(:field).required).to be false
  end
end

