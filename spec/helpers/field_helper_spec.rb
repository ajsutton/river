# -*- encoding : utf-8 -*-
require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the FieldHelper. For example:
#
# describe FieldHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe FieldHelper, type: :helper do
  
  it 'should generate an id' do
    field = build(:field, name: 'field_name')
    expect(render_field(field)).to have_tag '*', :with => { :id => 'fields_field_name' }
  end
  
  it 'should generate a name' do
    field = build(:field, name: 'field_name')
    expect(render_field(field)).to have_tag '*', :with => { :name => "fields[#{field[:id]}]" }
  end
  
  it 'should add custom options' do
    expect(render_field(build(:field), nil, { class: 'form-control' })).to have_tag '*', :with => { :class => 'form-control' }
  end
  
  describe 'string fields' do
    before :each do
      @field = build(:field, name: 'field_name', type: 'string')
    end
    
    it 'should generate an input tag' do
      expect(render_field(@field)).to have_tag 'input', :with => { :type => 'text' }
    end
    
    it 'should include the value when available' do
      expect(render_field(@field, build(:person, fields: { @field[:id] => 'field value' }))).to have_tag 'input', :with => { :value => 'field value' }
    end
  end  
  
  describe 'boolean fields' do
    before :each do
      @field = build(:field, name: 'field_name', type: 'boolean')
    end
    
    it 'should generate an input tag' do
      expect(render_field(@field)).to have_tag 'input', :with => { 
        :type => 'checkbox'
      }
    end
    
    it 'should include the value when available' do
      expect(render_field(@field, build(:person, fields: { @field[:id] => true }))).to have_tag 'input', :with => { :selected => 'selected' }
    end
  end
  
  describe 'integer fields' do
    before :each do
      @field = build(:field, name: 'field_name', type: 'integer')
    end
    
    it 'should generate an input tag' do
      expect(render_field(@field)).to have_tag 'input', :with => { :type => 'number' }
    end
    
    it 'should include the value when available' do
      expect(render_field(@field, build(:person, fields: { @field[:id] => 7 }))).to have_tag 'input', :with => { :value => '7' }
    end
  end
  
  describe 'date fields' do
    before :each do
      @field = build(:field, name: 'field_name', type: 'date')
    end
    
    it 'should generate an input tag' do
      expect(render_field(@field)).to have_tag 'input', :with => { :type => 'date' }
    end
    
    it 'should include the value when available' do
      expect(render_field(@field, build(:person, fields: { @field[:id] => '2015-07-03' }))).to have_tag 'input', :with => { :value => '2015-07-03' }
    end
  end
end

