# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe FieldSchema, type: :model do
  it 'has a valid factory' do
    expect(create(:field_schema)).to be_valid
  end

  it 'requires a church' do
    expect(build(:field_schema, church: nil)).to be_invalid
  end

  it 'can convert field name to ID' do
      field1 = build(:field, name: 'Field1')
      field2 = build(:field, name: 'Field2')
      schema = build(:field_schema, fields: [ field1, field2 ])
      expect(schema.id_for_name 'Field1').to eq field1[:id]
      expect(schema.id_for_name 'Field2').to eq field2[:id]
  end

  it 'returns nil when field name is unknown' do
      expect(build(:field_schema).id_for_name 'MyField1').to be nil
  end

  describe 'applies_to' do
    it 'is required' do
      expect(build(:field_schema, applies_to: nil)).to be_invalid
    end

    it 'must be one of the valid values' do
      expect(build(:field_schema, applies_to: 'person')).to be_valid
      expect(build(:field_schema, applies_to: 'churches')).to be_invalid
    end
  end

  describe 'fields' do
    it 'defaults to empty array' do
      expect(build(:field_schema).fields).to eq([])
    end

    it 'must not be nil' do
      expect(build(:field_schema, fields: nil)).to be_invalid
    end

    it 'must be an array' do
      expect(build(:field_schema, fields: "foo")).to be_invalid
    end

    it 'can be an empty array' do
      expect(build(:field_schema, fields: [])).to be_valid
    end

    it 'must allow valid fields' do
      expect(create(:field_schema, fields: [build(:field)]))
    end

    it 'must have a name for every value' do
      expect(build(:field_schema, fields: [build(:field, name: nil)])).to be_invalid
    end

    it 'must have a type for every value' do
      expect(build(:field_schema, fields: [build(:field, type: nil)])).to be_invalid
    end

    it 'type must be one of the supported values' do
      ['string', 'boolean', 'integer', 'date'].each { |val| expect(build(:field_schema, fields: [build(:field, type: val)])).to be_valid }
      expect(build(:field_schema, fields: [build(:field, type: 'foo')])).to be_invalid
    end

    it 'can have no required attribute' do
      expect(build(:field_schema, fields: [build(:field, required: nil)])).to be_valid
    end

    it 'must have a boolean as the value for required when present' do
      expect(build(:field_schema, fields: [build(:field, required: 'foo')])).to be_invalid
      expect(build(:field_schema, fields: [build(:field, required: true)])).to be_valid
    end
  end
end
