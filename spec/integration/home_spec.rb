require 'dsl_helper'

describe 'home page' do
  it 'displays a login button when not logged in' do
    $home.login_present!
  end
  
  it 'displays a logout button when not logged in' do
    $home.login
    $home.logout_present!
  end
  
  it 'displays login again after logging out' do
    $home.login
    $home.logout
    $home.login_present!
  end
end