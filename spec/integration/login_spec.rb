# -*- encoding : utf-8 -*-
require 'dsl_helper'

describe 'log in' do
  describe 'when logged in' do
    before :each do
      Dsl.home.login :user
    end
    
    it 'displays a logout button when logged in' do
      Dsl.home.logout_present!
    end

    describe 'with valid church' do
      before :each do
        Dsl.setup.create_church :church
      end
      
      it 'should link to people component' do
        Dsl.home.people_component_available!
      end
  
      it 'should link to admin' do
        Dsl.home.admin_component_available!
      end
    end
    
    describe 'without a church' do
      it 'should not link to people component' do
        Dsl.home.people_component_unavailable!
      end
  
      it 'should not link to admin' do
        Dsl.home.admin_component_unavailable!
      end
  
      it 'should provide create church button' do
        Dsl.home.create_church_available!
      end
    end
  end
  
  describe 'when not logged in' do
    it 'displays a login button when not logged in' do
      Dsl.home.login_present!
    end
  
    it 'displays login again after logging out' do
      Dsl.home.login :user
      Dsl.home.logout
      Dsl.home.login_present!
    end
  end
  
  describe 'initial setup' do
    it 'prompts to create a church on first log in' do
      Dsl.home.login :user
      Dsl.setup.create_church :church
      Dsl.home.on_home_page!
    end
  
    it 'does not prompt to create a church when one has already been created' do
      Dsl.home.login :user
      Dsl.setup.create_church :church
      Dsl.home.logout
      Dsl.home.login :user
      Dsl.home.on_home_page!
    end
  end
end

