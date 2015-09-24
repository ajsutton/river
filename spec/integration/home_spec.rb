require 'dsl_helper'

describe 'home page' do
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
end