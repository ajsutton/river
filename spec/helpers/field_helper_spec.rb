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
    field = build(:field, name: 'field_name', applies_to: 'person')
    expect(render_field(field)).to have_tag '*', :with => { :id => 'person_fields_field_name' }
  end
  
  it 'should generate a name' do
    field = build(:field, name: 'field_name', applies_to: 'person')
    expect(render_field(field)).to have_tag '*', :with => { :name => 'person[fields[field_name]]' }
  end
  
  describe 'string fields' do
    before :each do
      @field = build(:field, name: 'field_name', applies_to: 'person', type: 'string')
    end
    
    it 'should generate an input tag' do
      expect(render_field(@field)).to have_tag 'input', :with => { :type => 'text' }
    end
    
    it 'should include the value when available' do
      expect(render_field(@field, build(:person, fields: { field_name: 'field value' }))).to have_tag 'input', :with => { :value => 'field value' }
    end
  end  
  
  describe 'boolean fields' do
    before :each do
      @field = build(:field, name: 'field_name', applies_to: 'person', type: 'boolean')
    end
    
    it 'should generate an input tag' do
      expect(render_field(@field)).to have_tag 'input', :with => { 
        :type => 'checkbox'
      }
    end
    
    it 'should include the value when available' do
      expect(render_field(@field, build(:person, fields: { field_name: true }))).to have_tag 'input', :with => { :selected => 'selected' }
    end
  end
end
