# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe CustomField, type: :model do
  it 'has a valid factory' do
    expect(create(:custom_field)).to be_valid
  end
  
  it 'requires a church' do
    expect(build(:custom_field, church: nil)).to be_invalid
  end
  
  describe 'applies_to' do
    it 'is required' do
      expect(build(:custom_field, applies_to: nil)).to be_invalid
    end
    
    it 'must be one of the valid values' do
      expect(build(:custom_field, applies_to: 'person')).to be_valid
      expect(build(:custom_field, applies_to: 'churches')).to be_invalid
    end
  end
  
  describe 'fields' do
    it 'defaults to empty array' do
      expect(build(:custom_field).fields).to eq([])
    end
    
    it 'must not be nil' do
      expect(build(:custom_field, fields: nil)).to be_invalid
    end
    
    it 'must be an array' do
      expect(build(:custom_field, fields: "foo")).to be_invalid
    end
    
    it 'can be an empty array' do
      expect(build(:custom_field, fields: [])).to be_valid
    end
    
    it 'must allow valid fields' do
      expect(create(:custom_field, fields: [build(:field)]))
    end
    
    it 'must have a name for every value' do
      expect(build(:custom_field, fields: [build(:field, name: nil)])).to be_invalid
    end
    
    it 'must have a type for every value' do
      expect(build(:custom_field, fields: [build(:field, type: nil)])).to be_invalid
    end
    
    it 'type must be one of the supported values' do
      ['string', 'boolean', 'integer', 'date'].each { |val| expect(build(:custom_field, fields: [build(:field, type: val)])).to be_valid }
      expect(build(:custom_field, fields: [build(:field, type: 'foo')])).to be_invalid
    end
    
    it 'can have no required attribute' do
      expect(build(:custom_field, fields: [build(:field, required: nil)])).to be_valid
    end
    
    it 'must have a boolean as the value for required when present' do
      expect(build(:custom_field, fields: [build(:field, required: 'foo')])).to be_invalid
      expect(build(:custom_field, fields: [build(:field, required: true)])).to be_valid
    end
  end
end
