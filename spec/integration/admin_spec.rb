# -*- encoding : utf-8 -*-
require 'rails_helper'

describe 'Admin' do
  before :each do
    setup.login_with_church :user, :church
  end
  
  it 'should add new custom fields' do
    admin.add_person_field name: 'Custom Field 1', type: 'String', required: false
    people.add :person, fields: { 'Custom Field 1' => 'My Value' }
  end
end