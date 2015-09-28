# -*- encoding : utf-8 -*-
require 'rails_helper'

describe 'Admin' do
  before :each do
    setup.login_with_church :user, :church
  end
  
  it 'should add new custom fields', js: true do
    
  end
end