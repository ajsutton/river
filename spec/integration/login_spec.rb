# -*- encoding : utf-8 -*-
require 'dsl_helper'

describe 'log in' do
  it 'displays a login button when not logged in' do
    Dsl.home.login_present!
  end
  
  it 'displays a logout button when not logged in' do
    Dsl.home.login :user
    Dsl.home.logout_present!
  end
  
  it 'displays login again after logging out' do
    Dsl.home.login :user
    Dsl.home.logout
    Dsl.home.login_present!
  end
  
  it 'prompts to create a church on first log in' do
    Dsl.home.login :user
    Dsl.setup.create_church :church
    Dsl.home.on_home_page!
  end
  
  it 'should not prompt to create a church when one has already been created' do
    Dsl.home.login :user
    Dsl.setup.create_church :church
    Dsl.home.logout
    Dsl.home.login :user
    Dsl.home.on_home_page!
  end
  
  it 'should link to people component when logged in with valid church' do
    Dsl.setup.login_with_church :user, :church
    Dsl.home.people_component_available!
  end
  
  it 'should not link to people component when logged in without a church' do
    Dsl.home.login :user
    Dsl.home.people_component_unavailable!
  end
  
  it 'should provide create church button when logged in without a church' do
    Dsl.home.login :user
    Dsl.home.create_church_available!
  end
end

