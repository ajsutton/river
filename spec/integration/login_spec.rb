# -*- encoding : utf-8 -*-
require 'rails_helper'

describe 'log in' do
  describe 'when logged in' do
    before :each do
      home.login :user
    end
    
    it 'displays a logout button when logged in' do
      home.logout_present! current_user: :user
    end

    describe 'with valid church' do
      before :each do
        setup.create_church :church
      end
      
      it 'should link to people component' do
        home.people_component_available!
      end
  
      it 'should link to admin' do
        home.admin_component_available!
      end
    end
    
    describe 'without a church' do
      it 'should not link to people component' do
        home.people_component_unavailable!
      end
  
      it 'should not link to admin' do
        home.admin_component_unavailable!
      end
  
      it 'should provide create church button' do
        home.create_church_available!
      end
    end
  end
  
  describe 'when not logged in' do
    it 'displays a login button when not logged in' do
      home.login_present!
    end
  
    it 'displays login again after logging out' do
      home.login :user
      home.logout
      home.login_present!
    end
  end
  
  describe 'initial setup' do
    it 'prompts to create a church on first log in' do
      home.login :user
      setup.create_church :church
      home.on_home_page!
    end
  
    it 'does not prompt to create a church when one has already been created' do
      home.login :user
      setup.create_church :church
      home.logout
      home.login :user
      home.on_home_page!
    end
  end
end

